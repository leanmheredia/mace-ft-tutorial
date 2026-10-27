
# # installation
# module avail cuda
# conda activate mace
# pip install cuequivariance cuequivariance-torch cuequivariance-ops-torch-cu12
# cd mace
# pip install .

# use
import os
from ase import build
from mace.calculators import MACECalculator

# local settings from the repository .env (see .env.example)
try:
    from dotenv import load_dotenv, find_dotenv
    load_dotenv(find_dotenv())
except ImportError:
    pass

repo_root = os.environ.get("MACE_FT_ROOT", os.path.dirname(os.path.abspath(__file__)))
model_path = os.environ.get("TEST_MODEL", os.path.join(repo_root, "models", "mace-mp-0b3-medium.model"))

mace_calc = MACECalculator(model_paths=model_path, enable_cueq=True, device=os.environ.get("MACE_DEVICE", "cuda"))

atoms = build.molecule('H2O')
atoms.calc = mace_calc
atoms.get_forces()