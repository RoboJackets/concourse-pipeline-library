#/bin/bash

set -e
set -o pipefail
set -x

generate_pipeline () {
  spruce merge templates/$1.yml $(yq --raw-output ".merge[]" templates/$1.yml) common/*.yml $2 | spruce merge > generated/$3.yml
}

rm -f generated.yml

for pipeline_file in pipelines/*.yml
do
  template_name=$(yq --raw-output .template $pipeline_file)
  pipeline_name=$(echo $pipeline_file | python3 tools/grab_pipeline_name.py)

  echo "- set_pipeline: $pipeline_name" >> generated.yml
  echo "  file: generated/$pipeline_name.yml" >> generated.yml

  if [ $pipeline_name == "pipeline-library" ]
  then
    continue
  fi

  generate_pipeline $template_name $pipeline_file $pipeline_name
done

pipeline_file=pipelines/pipeline-library.yml
template_name=$(yq --raw-output .template $pipeline_file)
pipeline_name=$(echo $pipeline_file | python3 tools/grab_pipeline_name.py)

generate_pipeline $template_name $pipeline_file $pipeline_name
