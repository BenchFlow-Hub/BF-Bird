#!/bin/bash

chain_of_thought=$1
model=$2
if_use_knowledge=$3

echo "chain_of_thought: ${chain_of_thought}"
echo "model: ${model}"
echo "if_use_knowledge: ${if_use_knowledge}"

eval_path='./data/dev.json'
db_root_path='./data/dev_databases/'
data_output_path='./exp_result/turbo_output/'
data_kg_output_path='./exp_result/turbo_output_kg/'

if [ ${if_use_knowledge} == 'True' ]; then
    python3 -u ./src/gpt_request.py --db_root_path ${db_root_path} \
        --eval_path ${eval_path} --data_output_path ${data_kg_output_path} \
        --use_knowledge ${if_use_knowledge} --chain_of_thought ${chain_of_thought} \
        --model ${model}
else
    python3 -u ./src/gpt_request.py --db_root_path ${db_root_path} \
        --eval_path ${eval_path} --data_output_path ${data_output_path} \
        --use_knowledge ${if_use_knowledge} --chain_of_thought ${chain_of_thought} \
        --model ${model}
fi
