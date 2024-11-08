#!/bin/bash

# Build from local recipe
# Loop over singularity-def directory
for def in singularity-def/*.def; do
    # Get the name of the singularity image
    name=$(basename ${def} .def)
    image_path="${SINGULARITY_CACHEDIR}/${name}.img"

    # Check if the image already exists
    if [ -f "${image_path}" ]; then
        echo "Singularity image ${name}.img already exists in cache. Skipping..."
    else
        # Create the image
        echo "Creating singularity image ${name}.img..."
        singularity build \
            ${image_path} \
            singularity-def/${name}.def
    fi
done