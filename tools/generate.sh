#/bin/bash

set -e
set -o pipefail
set -x

generate_pipeline () {  if test -f "go-patch/$3.yml"
  then
    GOPATCH="go-patch/$3.yml"
  else
    GOPATCH=""
  fi
  spruce merge templates/$1.yml $(yq --raw-output ".merge[]" templates/$1.yml) common/*.yml $2 | spruce merge --go-patch - $GOPATCH > generated/$3.yml
}

rm -f generated.yml
mkdir -p generated

for team in pipelines/*
do
  for pipeline_file in $team/*.yml
  do
    template_name=$(yq --raw-output .template $pipeline_file)
    pipeline_name=$(echo $pipeline_file | python3 tools/parse_filename.py pipeline)
    team_name=$(echo $pipeline_file | python3 tools/parse_filename.py team)

    echo "- set_pipeline: $pipeline_name" >> generated.yml
    echo "  file: generated/$pipeline_name.yml" >> generated.yml
    echo "  team: $team_name" >> generated.yml

    if [ $pipeline_name == "pipeline-library" ]
    then
      continue
    fi

    generate_pipeline $template_name $pipeline_file $pipeline_name
  done
done

pipeline_file=pipelines/main/pipeline-library.yml
template_name=$(yq --raw-output .template $pipeline_file)
pipeline_name=$(echo $pipeline_file | python3 tools/parse_filename.py pipeline)

generate_pipeline $template_name $pipeline_file $pipeline_name
