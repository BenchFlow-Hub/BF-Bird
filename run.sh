#!/bin/bash

CHAIN_OF_THOUGHT=${CHAIN_OF_THOUGHT:-"True"}
MODEL=${MODEL:-"gpt-3.5-turbo"}
USE_KNOWLEDGE=${USE_KNOWLEDGE:-"True"}
INTELLIGENCE_URL=${INTELLIGENCE_URL:-"http://0.0.0.0:8004"}

cd llm

echo "Running GPT batch generation..."
chmod +x ./run/run_gpt.sh
echo "running ./run/run_gpt.sh ${CHAIN_OF_THOUGHT} ${MODEL} ${USE_KNOWLEDGE} ${INTELLIGENCE_URL}"
./run/run_gpt.sh "${CHAIN_OF_THOUGHT}" "${MODEL}" "${USE_KNOWLEDGE}" "${INTELLIGENCE_URL}"

echo "Running evaluation..."
sh ./run/run_evaluation.sh "${CHAIN_OF_THOUGHT}" "${USE_KNOWLEDGE}"
