#!/bin/bash
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source .bash_profile
conda install jupyter pandas fastparquet dask distributed plotly
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem

jupyter notebook --ip 0.0.0.0 --certfile mycert.pem --keyfile mykey.key
