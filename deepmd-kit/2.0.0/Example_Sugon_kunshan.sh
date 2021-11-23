#!/bin/bash
#SBATCH -p
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -e err
#SBTACH -o out



source ...../venv/bin/activate
dp train input.json


dp freeze -o frozen_model.pb

