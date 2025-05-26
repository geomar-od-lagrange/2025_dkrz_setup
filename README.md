# 2025 DKRZ Setup for Parcels and VIKING experiments

## Velocity Data

### Download

We use the last 10 years of nest-domain data from the VIKING20CJRAshort data pulished on WDCC: [10.26050/WDCC/VIKING20XJRAshort](https://doi.org/10.26050/WDCC/VIKING20XJRAshort)

In [scripts/calculate_VIKING20XJRAshort_w.sh](scripts/calculate_VIKING20XJRAshort_w.sh), [scripts/compress_VIKING20XJRAshort_w.sh](scripts/compress_VIKING20XJRAshort_w.sh), and [scripts/download_VIKING20XJRAshort.sh](scripts/download_VIKING20XJRAshort.sh), there's a sequence of batch scripts for downloading the UVT fields and the mesh files, for calculating the vertical velocities, and for compressing the resulting `grid_W` files.

The W calculation is done with CDFTOOLS in a container built according to <https://github.com/willirath/cdftools_container>.

### Testing the downloads

There's a notebook [notebooks/test_viking_data.ipynb](notebooks/test_viking_data.ipynb) run with [notebooks/run_test_viking_data.sh](notebooks/run_test_viking_data.sh) (results in [notebooks/test_viking_data.exe.ipynb](notebooks/test_viking_data.exe.ipynb)) which uses all the downloaded data to make sure there are no corrupted files. (Jblob tends to stall sometimes and is not really good at letting the user know what went wrong...)

## Environment

### Kernel installation

Kernel installation is handled in [scripts/setup_parcels_env.sh](scripts/setup_parcels_env.sh).  It essentially follows <https://docs.dkrz.de/doc/software&services/jupyterhub/kernels.html#use-your-own-kernel> but uses `mamba`  for the env resolution (because it's faster), and creates a Juptyer kernel spec which uses `conda run` to make sure the kernel is within a properly activated conda env, because we want to use the gcc installed in the env etc.

### Parcels test

In [notebooks/test_parcels.ipynb](notebooks/test_parcels.ipynb), there's a simple Brownian motion test run in the newly installed env.