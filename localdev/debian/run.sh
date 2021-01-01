#!/usr/bin/env bash

docker rm -f localdev
docker run -ti --rm --name localdev \
    --add-host master:172.17.0.1 \
    --volume $(pwd)/tmp/data:/data \
	--volume $(pwd)/tmp/mysql:/var/lib/mysql \
    jarry6/localdev:v1 sh
