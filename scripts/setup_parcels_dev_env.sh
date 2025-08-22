#!/usr/bin/env bash

ENV_NAME="parcels_dev"

# init conda dirs
module load python3
conda config --add envs_dirs /work/bk1450/$USER/conda/envs
conda config --add pkgs_dirs /work/bk1450/$USER/conda/pkgs
conda config --set auto_activate_base false
conda init
conda shell.bash activate base

# create dev env (still without parcels)
mamba env create -n ${ENV_NAME} -f environment.yml

# activate
conda shell.bash activate ${ENV_NAME}

# add additional relevant packages
mamba install -y -c conda-forge python=3 cartopy cftime cmocean copernicusmarine dask datashader distributed geopandas geoviews gsw h5netcdf h5py holoviews hvplot ipykernel matplotlib netcdf4 numcodecs numpy openblas openpyxl pandas papermill pys2index python-blosc rasterio regionmask scikit-learn scipy seaborn seawater sparse xarray xhistogram xoak zarr

# install local copy of Parcels code
python -m pip install -e .  # -e : editable install

# install kernel
python -m ipykernel install --user --name ${ENV_NAME} --display-name="${ENV_NAME}"

cat > $HOME/.local/share/jupyter/kernels/${ENV_NAME}/kernel.json <<EOF
{
 "argv": [
  "conda",
  "run",
  "-n",
  "${ENV_NAME}",
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