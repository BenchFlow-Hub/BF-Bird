#!/bin/bash

CHAIN_OF_THOUGHT="True"
MODEL="gpt-3.5-turbo"
USE_KNOWLEDGE="True"

cd llm

# echo "Running GPT batch generation..."
# chmod +x ./run/run_gpt.sh
# echo "running ./run/run_gpt.sh ${CHAIN_OF_THOUGHT} ${MODEL} ${USE_KNOWLEDGE}"
# ./run/run_gpt.sh "${CHAIN_OF_THOUGHT}" "${MODEL}" "${USE_KNOWLEDGE}"

echo "Running evaluation..."
sh ./run/run_evaluation.sh "${CHAIN_OF_THOUGHT}" "${USE_KNOWLEDGE}"
