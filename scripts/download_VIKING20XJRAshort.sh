#!/bin/bash
#SBATCH --job-name=VIKING
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --time=5-00:00:00
#SBATCH --partition=shared
#SBATCH --account=bk1450

# make sure we jblob
module load jblob
module list

# create output dir
outdir=/work/bk1450/$USER/data/VIKING20XJRAshort
mkdir -p ${outdir}

cd ${outdir}

# get TUV data for 2010 onwards
srun --export=ALL --ntasks 1 --nodes 1 --exclusive -c 10 /bin/bash -c -l 'for g in "T" "U" "V"; do for n in {361..480}; do echo "timeout -v 1200 jblob --dataset VIKING20XJRAshortnest${g} --rmin ${n} --rmax ${n}"; done; done | xargs -n1 -P10 -I {} bash -c -l "{}"'