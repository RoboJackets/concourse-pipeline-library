#/bin/sh

set -e
set -o pipefail
set -x

for generated_file in generated/*.yml
do
  fly validate-pipeline --config $generated_file
done
