#!/bin/bash

CHAIN_OF_THOUGHT=${CHAIN_OF_THOUGHT:-"True"}
USE_KNOWLEDGE=${USE_KNOWLEDGE:-"True"}
INTELLIGENCE_URL=${INTELLIGENCE_URL:-"http://0.0.0.0:8004"}

cd llm

echo "Running GPT batch generation..."
chmod +x ./run/run_predict.sh
echo "running ./run/run_predict.sh ${CHAIN_OF_THOUGHT} ${USE_KNOWLEDGE} ${INTELLIGENCE_URL}"
bash ./run/run_predict.sh "${CHAIN_OF_THOUGHT}" "${USE_KNOWLEDGE}" "${INTELLIGENCE_URL}"

echo "Running evaluation..."
bash ./run/run_evaluation.sh "${CHAIN_OF_THOUGHT}" "${USE_KNOWLEDGE}"
