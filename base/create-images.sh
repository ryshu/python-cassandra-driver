#!/usr/bin/env bash
python_versions=();

IFS=$'\n'
python_versions=(`cat $1`)
IFS=$' \t\n'

docker login

for python_version in "${python_versions[@]}"
do
    docker build --pull --build-arg python_version="${python_version}" -t "spklabs/spk-python:$python_version" .
    docker push "spklabs/spk-python:$python_version"
done
