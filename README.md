# Software Environment Management

[![singularity-def](https://github.com/houlstonlab/singularity-def/actions/workflows/singularity-build-push.yml/badge.svg)](https://github.com/houlstonlab/singularity-def/actions/workflows/singularity-build-push.yml)

[![conda-env](https://github.com/houlstonlab/conda-env/actions/workflows/conda-build-export.yml/badge.svg)](https://github.com/houlstonlab/conda-env/actions/workflows/conda-build-export.yml)

[![docker-files](https://github.com/houlstonlab/docker-files/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/houlstonlab/docker-files/actions/workflows/docker-build-push.yml)

This repository automates management of various environments and containers for bioinformatics tools. It is intended to:

- **Collect recipes** for building environments and containers
- **Automate building and caching** of these environments/containers  
- **Create a local cache** of built environments/containers for reuse

## Directory Structure

```
software-env/
├── available-images-environments.txt  # List of available images
├── singularity-def/                   # Singularity recipes (built using GHA)
├── docker-files/                      # Docker recipes (built using GHA)
├── conda-yaml/                        # Conda environment recipes (built using GHA)
├── resources/                         # URLs to online registries
├── scripts/                           # Scripts to pull and build images
└── Makefile                           # Build targets
```

## Usage

### Build All Environments

```bash
# Run all targets
make

# Run all targets for a specific type of container
make singularity

# Run specific target
make pull-singularity
```

### Makefile Targets

The Makefile includes targets for:
- **Pulling** (and downloading) from online registries
- **Building** from local recipes
- **Listing** images/environments in the cache

## Adding New Containers/Environments

### Local Recipe
Add a `Dockerfile`, `.def` or `.yaml` to the corresponding directory:
- **Singularity**: Add `toolname_version/Singularity.def` to `singularity-def/`
- **Docker**: Add `Dockerfile` to `docker-files/toolname_version/`
- **Conda**: Add `environment.yml` to `conda-env/toolname_version/`

### Online Registry
Add a new line to `resources/*-urls.txt` and rerun the pull target.

> **Note:** The `list-all` target should be executed last to update the list of available images and environments.

## Integration with Analysis Tools

Using this directory as a central cache depends on the tool being used.

### Nextflow Pipelines

Set cache environment variables:

```bash
export NXF_CONDA_CACHEDIR="/path/to/dir/software-env/conda"
export SINGULARITY_CACHEDIR="/path/to/dir/software-env/singularity"
```

Or use full paths in processes:

```groovy
process doThat {
    // To use a pre-built conda environment
    conda "/path/to/dir/software-env/conda/tool"

    // To build and use conda from file
    conda "/path/to/dir/software-env/conda-yaml/tool.yaml"

    // To use a local singularity container
    container "file:///path/to/dir/software-env/singularity/tool.sif"
    
    script:
    """
    # Your analysis commands here
    """
}
```

## Environment Variables

The scripts expect default directories to be set for the caches:

```bash
export SINGULARITY_CACHEDIR="/path/to/singularity/cache"
export DOCKER_CACHEDIR="/path/to/docker/cache" 
export CONDA_CACHEDIR="/path/to/conda/cache"
```

If not set, they will be created as subdirectories in the current working directory.

## Notes

- **Docker** needs to be run on local machines
- **nf-core** needs to be installed first for nf-core pipelines
- **GitHub Actions** automatically build and push containers when recipes are updated
