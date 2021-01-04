#!/bin/bash

chmod +x ./etc/profile.d/1ce.sh

source <(grep -E '^\w+=' ./etc/profile.d/1ce.sh)

echo $PATH_1CE

PATH=$PATH:$PATH_1CE