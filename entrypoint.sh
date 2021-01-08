#!/bin/bash
set -e
echo "Running: terraform $@"
terraform "$@"
