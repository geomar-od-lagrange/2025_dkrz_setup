#!/bin/bash
#SBATCH --job-name=VIKING
#SBATCH --ntasks=3
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=3
#SBATCH --mem=32G
#SBATCH --cpus-per-task=6
#SBATCH --time=8:00:00
#SBATCH --partition=compute
#SBATCH --account=bk1450

# make sure we jblob
module load jblob
module list

# create output dir
outdir=/work/bk1450/$USER/data/VIKING20XJRAshort
mkdir -p ${outdir}

cd ${outdir}
srun --export=ALL --ntasks 1 --nodes 1 --exclusive -c 6 /bin/bash -c -l "seq 1 6 | xargs -P6 -n1 sh -c 'jblob --dataset VIKING20XJRAshortnestU --rmin \$((1 + (\$1 - 1) * 80)) --rmax \$((\$1 * 80))' _" &
srun --export=ALL --ntasks 1 --nodes 1 --exclusive -c 6 /bin/bash -c -l "seq 1 6 | xargs -P6 -n1 sh -c 'jblob --dataset VIKING20XJRAshortnestV --rmin \$((1 + (\$1 - 1) * 80)) --rmax \$((\$1 * 80))' _" &
srun --export=ALL --ntasks 1 --nodes 1 --exclusive -c 6 /bin/bash -c -l "seq 1 6 | xargs -P6 -n1 sh -c 'jblob --dataset VIKING20XJRAshortnestT --rmin \$((1 + (\$1 - 1) * 80)) --rmax \$((\$1 * 80))' _" &

wait
cd -