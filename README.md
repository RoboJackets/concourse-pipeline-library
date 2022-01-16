# concourse-pipeline-library
[![GitHub license](https://img.shields.io/github/license/RoboJackets/concourse-pipeline-library)](https://github.com/RoboJackets/concourse-pipeline-library/blob/main/LICENSE) [![CI](https://concourse.robojackets.org/api/v1/teams/information-technology/pipelines/pipeline-library/jobs/build-main/badge)](https://concourse.robojackets.org/teams/information-technology/pipelines/pipeline-library)

Collection of reusable tasks and pipelines for Concourse

## Usage

For testing, you can generate the pipeline files locally.

Install dependencies:
- Python >= 3.6
- [`jq`](https://stedolan.github.io/jq/download/)
- [`yq`](https://pypi.org/project/yq/) (be sure to install the Python version)
- [`spruce`](https://github.com/geofffranks/spruce)

Generate the pipelines by running `tools/generate.sh` **from the root of this repository**