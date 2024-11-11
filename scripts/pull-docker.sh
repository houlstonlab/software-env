#!/bin/bash

# Loop over the remaining lines
tail -n +2 resources/docker-urls.txt | \
while IFS=',' read -r -a values; do
	# Assign the values to the variables
	name=${values[0]}
	revision=${values[1]}
	url=${values[2]}

	# Pull the docker containers
    docker pull ${url}:${revision}
	docker save ${url}:${revision} > ${DOCKER_CACHEDIR}/${name}.${revision}.tar
done
