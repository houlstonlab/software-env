#!/bin/bash

# Build from remote docker image
# Loop over the docker-urls lines
tail -n +2 resources/docker-urls.txt | \
while IFS=',' read -r -a values; do
	# Assign the values to the variables
	name=${values[0]}
	revision=${values[1]}
	url=${values[2]}

	# Pull the Singularity containers
	singularity build --force singularity/${name}.${revision}.sif docker://${url}:${revision}
done

# Build from local recipe
# Loop over singularity-def directory
for def in singularity-def/*.def; do
	# Get the name of the singularity image
	name=$(basename ${def} .def)

	# Create the image
	singularity build singularity/${name}.sif singularity-def/${name}.def
done

# Build from local Docker image
# Loop over dockers directory
for d in docker/*.tar; do
	# Get the name of the docker image
	name=$(basename ${d} .tar)

	# Create the image
	singularity build singularity/${name}.sif docker-archive:${d}
done

