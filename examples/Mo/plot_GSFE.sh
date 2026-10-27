#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/.env}"
[ -f "$ENV_FILE" ] && { set -a; . "$ENV_FILE"; set +a; }

MACE_FT_ROOT="${MACE_FT_ROOT:-$REPO_ROOT}"
RESULTS_DIR="${MO_WORK_DIR:-$MACE_FT_ROOT/examples/Mo}/results/Amir_Mo-17Jan1120-3"
MODEL_PATH="${GSFE_MODEL_PATH:-$RESULTS_DIR/Amir_Mo-17Jan1120-3_run-3_stagetwo.model}"
SURFACE_TYPE=110 # 110 or 121
OUTPUT_FILE=$RESULTS_DIR/gsfe_ft_medium_${SURFACE_TYPE}_noucf.png

# Run the Python script
python "$SCRIPT_DIR/plot_GSFE.py" --model_path "$MODEL_PATH" --output_path "$OUTPUT_FILE" --surface_type "$SURFACE_TYPE" --device "${MACE_DEVICE:-cuda}"
