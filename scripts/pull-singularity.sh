#!/bin/bash

# Pull from online registry
# Loop over the remaining lines
tail -n +2 resources/singularity-urls.txt | \
while IFS=',' read -r -a values; do
	# Assign the values to the variables
	name=${values[0]}
	revision=${values[1]}
	url=${values[2]}

	# Pull the Singularity containers
    singularity pull --force --name singularity/${name}.${revision}.sif ${url}
done

# Download nf-core pipelines
# Install nextflow (Run once)
module load java/jdk15.0.1
# python3 -m venv venv
# source venv/bin/activate
# pip install --upgrade pip
# pip install nextflow
# pip install nf-core

# source venv/bin/activate

export NXF_SINGULARITY_CACHEDIR="singularity"

tail -n +2 resources/nfcore-pipelines.txt | \
while IFS=',' read -r -a values; do
	# Assign the values to the variables
	name=${values[0]}
	revision=${values[1]}
	url=${values[2]}

	# Pull the Singularity containers
	nf-core pipelines download \
		${name} -r ${revision} \
		-s singularity \
		-d 10 -x none -u copy \
		-o tmp
	rm -rf tmp 
done