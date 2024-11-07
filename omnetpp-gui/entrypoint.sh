#!/bin/bash
set -e

# Source .profile so all commands have a proper environment
# (by default docker does not source the initialization files on shells)
if [ -e /root/.profile ]; then
 source /root/.profile;
fi

if [ -e /root/omnetpp/setenv ]; then
 source /root/omnetpp/setenv;
fi

# Execute the command passed to the container
exec "$@"
