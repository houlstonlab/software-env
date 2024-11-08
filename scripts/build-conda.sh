#!/bin/bash

# Loop over conda-yaml directory
for yaml in conda-yaml/*.yaml; do
    # Get the name of the conda environment
    name=$(basename ${yaml} .yaml)
    env_dir="${CONDA_CACHEDIR}/${name}"
    
    # Check if the environment already exists
    if [ -d "${env_dir}" ]; then
        echo "Conda environment ${name} already exists in cache. Skipping..."
    else
        # Create the conda environment
        echo "Creating conda environment ${name}..."
        conda env create \
            -f conda-yaml/${name}.yaml \
            --prefix ${env_dir}
    fi
done