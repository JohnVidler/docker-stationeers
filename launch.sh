#!/bin/bash

echo "Proxy launch script 1.0..."
echo "Scripts path = /opt/launch/launch.d"

# DO NOT DIRECTLY EDIT THIS FILE
#
# Instead, add numerically ordered files in launch.d/ to have them run on startup.

run-parts -v /opt/launch/launch.d
