#!/bin/bash

source ./PrivGen.sh

PrivFactory() {
     priv_gen=(PrivGenerator)

     $priv_gen "$1" "$2"
}
