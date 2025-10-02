#!/usr/bin/env bash

ENV_NAME="parcels_dev_pixi"
SRC_PATH=$HOME/src

# not entirely sure about this one
module purge
module load git

# SKIPPED: install pixi

# get parcels repo
git clone https://github.com/oceanparcels/parcels.git ${SRC_PATH}/parcels_dev

mkdir -p $HOME/.local/share/jupyter/kernels/${ENV_NAME}
cat > $HOME/.local/share/jupyter/kernels/${ENV_NAME}/kernel.json <<EOF
{
 "argv": [
  "$HOME/.pixi/bin/pixi",
  "run",
  "--manifest-path",
  "${SRC_PATH}/parcels_dev",
  "python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "${ENV_NAME}",
 "language": "python",
 "metadata": {
  "debugger": true
 }
}
EOF