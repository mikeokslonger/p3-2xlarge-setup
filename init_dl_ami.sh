#!/bin/bash

echo "Installing tmux, htop"
sudo yum install -y tmux htop


echo "Writing out password"
mkdir $HOME/.jupyter
echo '{
  "NotebookApp": {
    "password": "sha1:501e4830926a:a14e9764e5fa9cd50d8e386f71ff4052e79d2d8f"
  }
}' > $HOME/.jupyter/jupyter_notebook_config.json


echo "Fixing jupyter"
conda install -y jupyter jupyterlab nodejs -c conda-forge
mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding
jupyter labextension install @jupyterlab/plotly-extension

source activate pytorch_p36
conda install -y fastparquet pyarrow python-snappy jupyterlab nodejs -c conda-forge
pip install tqdm s3fs

echo "Starting Jupyter in tmux session"
cd $HOME
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem -subj '/C=AU'
tmux new-session -d -s "jupyter" "bash -c 'jupyter notebook --ip 0.0.0.0 --certfile mycert.pem --keyfile mykey.key'"



