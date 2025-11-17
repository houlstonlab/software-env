#!/bin/bash

# Loop over conda-env directory structure
for dir in conda-env/*/; do
    # Check if directory contains environment.yml file
    if [[ -f "$dir/environment.yml" ]]; then
        # Get the name of the conda environment from directory name
        name=$(basename "${dir%/}")
        env_dir="${CONDA_CACHEDIR}/${name}"
        
        # Check if the environment already exists
        if [ -d "${env_dir}" ]; then
            echo "Conda environment ${name} already exists in cache. Skipping..."
        else
            # Create the conda environment
            echo "Creating conda environment ${name}..."
            conda env create \
                -f ${dir}/environment.yml \
                --prefix ${env_dir}
        fi
    fi
done