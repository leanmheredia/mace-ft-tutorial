#!/bin/bash

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/.env}"
[ -f "$ENV_FILE" ] && { set -a; . "$ENV_FILE"; set +a; }

MACE_FT_ROOT="${MACE_FT_ROOT:-$REPO_ROOT}"
MACE_RUN_TRAIN="${MACE_RUN_TRAIN:-mace_run_train}"
MACE_DEVICE="${MACE_DEVICE:-cuda}"
ROOT_DIR="${MO_WORK_DIR:-$MACE_FT_ROOT/examples/Mo}"
SEED=3
RES_DIR=Amir_Mo-17Jan1120-$SEED

cd "$ROOT_DIR" || exit 1

$MACE_RUN_TRAIN \
    --name=$RES_DIR \
    --foundation_model="$MACE_FT_ROOT/models/mace-mp-0b3-medium.model"  \
    --model_dir=results/$RES_DIR \
    --log_dir=results/$RES_DIR \
    --checkpoints_dir=results/$RES_DIR \
    --results_dir=results/$RES_DIR \
    --train_file="$MACE_FT_ROOT/examples/Mo/train.xyz" \
    --valid_file="$MACE_FT_ROOT/examples/Mo/test.xyz" \
    --energy_weight=1.0 \
    --forces_weight=10.0 \
    --stress_weight=0.0 \
    --loss='universal' \
    --forces_key=dft_force \
    --energy_key=dft_energy \
    --lr=0.0005 \
    --scaling="rms_forces_scaling" \
    --batch_size=4 \
    --max_num_epochs=150 \
    --ema \
    --ema_decay=0.99 \
    --weight_decay=1e-6 \
    --amsgrad \
    --default_dtype="float64" \
    --clip_grad=10 \
    --device=$MACE_DEVICE \
    --seed=$SEED \
    --num_samples_pt=500 \
    --swa_energy_weight=100.0 \
    --swa_forces_weight=10.0 \
    --swa_stress_weight=0.0 \
    --swa \
    --swa_lr=5e-4
