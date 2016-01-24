#!/bin/bash
 
set -o errexit # Exit on error

npm install
./make.sh
node server.js & ./run-postgrest
