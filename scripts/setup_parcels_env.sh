#!/usr/bin/env bash

# init conda dirs
module load python3
conda config --add envs_dirs /work/bk1450/$USER/conda/envs
conda config --add pkgs_dirs /work/bk1450/$USER/conda/pkgs
conda config --set auto_activate_base false
conda init
conda shell.bash activate base

mamba create -y -n parcels_3.1.2 -c conda-forge python=3 cartopy cftime cmocean dask datashader distributed geopandas geoviews gsw h5netcdf h5py holoviews hvplot ipykernel matplotlib netcdf4 numcodecs numpy openblas openpyxl pandas papermill parcels=3.1.2 pip pys2index python-blosc rasterio regionmask scikit-learn scipy seaborn seawater sparse xarray xhistogram xoak zarr

# kernel install
conda shell.bash activate parcels_3.1.2
python -m ipykernel install --user --name parcels_3.1.2 --display-name="parcels_3.1.2"

cat $HOME/.local/share/jupyter/kernels/parcels_3.1.2/kernel.json <<EOF
{
 "argv": [
  "conda",
  "run",
  "-n",
  "parcels_3.1.2",
  "python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "parcels_3.1.2",
 "language": "python",
 "metadata": {
  "debugger": true
 }
}
EOF