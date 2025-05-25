#!/bin/bash
#SBATCH --job-name=VIKING
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=64
#SBATCH --time=08:00:00
#SBATCH --partition=compute
#SBATCH --account=bk1450

module load singularity
module list

# create output dir
outdir=/work/bk1450/$USER/data/VIKING20XJRAshort

cd ${outdir}

ln -s VIKING20X.L46-KKG36107B_mask_cell_size_nest.nc mesh_zgr.nc
ln -s VIKING20X.L46-KKG36107B_mask_cell_size_nest.nc mesh_hgr.nc

ls -1 1_VIKING20X.L46-KKG36107B_1d_201*U.nc | rev | cut -d_ -f 2- | rev | xargs -n1 -P64 -I {} \
    singularity run -B $PWD:/wrk --pwd /wrk ~/work_bk1450/containers/cdftools.sif cdfw \
    -u {}_U.nc -v {}_V.nc -o {}_W.nc

cd -