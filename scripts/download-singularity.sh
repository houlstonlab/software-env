#!/bin/bash

#SBATCH -J download-singularity
#SBATCH -o download-singularity.out
#SBATCH -e download-singularity.err
#SBATCH -p compute
#SBATCH -t 12:00:00
#SBATCH -c 2

# Install nextflow (Run once)
module load java/jdk15.0.1
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install nextflow
pip install nf-core

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
		-o tmp \
		--force
	rm -rf tmp 
done
