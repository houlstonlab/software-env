#!/bin/bash

#SBATCH -J pull-singularity
#SBATCH -o pull-singularity.out
#SBATCH -e pull-singularity.err
#SBATCH -p compute
#SBATCH -t 12:00:00
#SBATCH -c 2

# Pull from online registry
# Loop over the remaining lines
tail -n +2 resources/singularity-urls.txt | \
while IFS=',' read -r -a values; do
	# Assign the values to the variables
	name=${values[0]}
	revision=${values[1]}
	url=${values[2]}

	# Pull the Singularity containers
    singularity pull --force \
		--name ${SINGULARITY_CACHEDIR}/${name}.${revision}.img \
		${url}
done
