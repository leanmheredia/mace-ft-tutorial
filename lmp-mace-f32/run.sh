#!/bin/bash
#SBATCH -p cpu-5218
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40

# Under sbatch the script runs from a spool copy, so use the submit directory
SCRIPT_DIR="${SLURM_SUBMIT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/.env}"
[ -f "$ENV_FILE" ] && { set -a; . "$ENV_FILE"; set +a; }

LAMMPS_MACE_MODEL="${LAMMPS_MACE_MODEL:-$REPO_ROOT/lmp-mace-f32/mace-ft-tutorial-main-3_compiled_f32.model-lammps.pt}"

module load "${LAMMPS_MODULE:-lammps/28Mar2023}"

lmp -k on g 1 -sf kk -var mace_model "$LAMMPS_MACE_MODEL" -in mace-lmp.in
