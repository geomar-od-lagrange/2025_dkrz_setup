#!/usr/bin/env bash

# init conda dirs
module load python3
conda config --add envs_dirs /work/bk1450/$USER/conda/envs
conda config --add pkgs_dirs /work/bk1450/$USER/conda/pkgs
conda config --set auto_activate_base false
conda init
conda shell.bash activate base

# env
curl -o /tmp/parcels_env.yml -L https://raw.githubusercontent.com/geomar-od-lagrange/parcels-container/ddf9a3a18da036ebcbb180e7ceeba533d09586a3/environment.yml
conda env create -n parcels_ddf9a3a -f /tmp/parcels_env.yml
conda install -n parcels_ddf9a3a -c conda-forge ipykernel ipython

# kernel install
conda shell.bash activate parcels_ddf9a3a
python -m ipykernel install --user --name parcels_ddf9a3a --display-name="parcels_ddf9a3a"