#!/bin/bash

# Loop over conda-yaml directory
for yaml in conda-yaml/*.yaml; do
	# Get the name of the conda environment
	name=$(basename ${yaml} .yaml)
	# Create the conda environment
	conda env create -f conda-yaml/${name}.yaml --prefix conda/${name}
done
