#!/bin/bash 


source ./PrivFactory.sh

read -p "Input username: " username
read -p "Input host: " host

priv_factory=(PrivFactory)

$priv_factory "${username[@]}" "${host[0]}"

echo "Done"


