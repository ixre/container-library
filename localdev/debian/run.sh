#!/usr/bin/env bash

#podman rm -f localdev1
podman run -ti --rm --name localdev1 \
    --add-host master:172.17.0.1 \
    --volume $(pwd)/tmp/data:/data \
	--volume $(pwd)/tmp/mysql:/var/lib/mysql \
    jarry6/localdev sh
