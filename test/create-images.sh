#!/usr/bin/env bash
python_versions=();

IFS=$'\n'
python_versions=(`cat $1`)
IFS=$' \t\n'

docker login

for python_version in "${python_versions[@]}"
do
    docker build --pull --build-arg python_version="${python_version}" -t "benbk/spk-python:$python_version-test" .
    docker push "benbk/spk-python:$python_version-test"
done