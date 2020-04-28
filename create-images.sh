#!/usr/bin/env bash
python_versions=();

IFS=$'\n'
python_versions=(`cat $1`)
IFS=$' \t\n'

for python_version in "${python_versions[@]}"
do
    docker build --pull --build-arg python_version="${python_version}" -t "benbk/spk-python:$python_version" .
    for i in "${!tags_args[@]}"
    do
        if [[ $((i%2)) -eq 1 ]]; then
            docker push ${tags_args[i]}
        fi
    done
done
