#!/bin/bash

# stop the container
docker stop boinc
# throw the container away so we can re-start it
docker rm boinc
