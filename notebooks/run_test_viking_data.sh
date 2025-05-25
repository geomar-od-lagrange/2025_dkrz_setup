#!/usr/bin/env bash
#SBATCH --job-name="test read VIKING"
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --mem=200G
#SBATCH --cpus-per-task=32
#SBATCH --time=08:00:00
#SBATCH --partition=compute
#SBATCH --account=bk1450

module load python3

jupyter nbconvert --execute --to=notebook --output=test_viking_data.exe.ipynb test_viking_data.ipynb