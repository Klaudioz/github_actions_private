#!/bin/bash

# pr_tests.sh
# -----------------------------------
# Automation utility which is able to run certain test in a certain cloud
# getting labels for a PR in GitHub. If the PR doesn't have any of this
# particular labels, this code won't execute anything.
# -----------------------------------
#
# ##################################################

# Cleaning the json. Removing spaces, slashs and newlines
labels_json=$(echo "${1}" | sed 's/\\//g' | tr -d '\n' |tr -d ' ')

# Storing the name of the labels to an array using jq
for row in $(echo "${labels_json}" | jq -c '.[]'); do
    labels_str+=( $(echo "${row}" | jq -c '.name') )
done

for value in "${labels_str[@]}"
do
    if [[ "$value" =~ "e2e_gcloud" ]] || [[ "$value" =~ "e2e_aws" ]] || [[ "$value" =~ "e2e_do" ]] || [[ "$value" =~ "e2e_azure" ]] || [[ "$value" =~ "e2e_eks" ]]; then
        echo "${value}"
    fi
done
