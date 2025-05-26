#!/bin/bash
#SBATCH --job-name=VIKING
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=60
#SBATCH --time=08:00:00
#SBATCH --partition=compute
#SBATCH --account=bk1450

module load netcdf-c
module list

# create output dir
outdir=/work/bk1450/$USER/data/VIKING20XJRAshort

cd ${outdir}

ls -1 1_VIKING20X.L46-KKG36107B_1d_201*W.nc | xargs -n1 -P60 -I{} nccopy -4 -s -d 1 -c time_counter/1 -c depthw/1 -c y/100 -c x/100 {} _{}
ls -1 1_VIKING20X.L46-KKG36107B_1d_201*W.nc | xargs -n1 -P60 -I{} mv -v _{} {}

cd -