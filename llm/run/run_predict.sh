#!/bin/bash

chain_of_thought=$1
if_use_knowledge=$2
intelligence_url=$3

echo "chain_of_thought: ${chain_of_thought}"
echo "if_use_knowledge: ${if_use_knowledge}"
echo "intelligence_url: ${intelligence_url}"

eval_path='./data/dev.json'
db_root_path='./data/dev_databases/'
data_output_path='../prediction_result/turbo_output/'
data_kg_output_path='../prediction_result/turbo_output_kg/'

if [ ${if_use_knowledge} == 'True' ]; then
    echo "using knowledge"
    if [ ${chain_of_thought} == 'True' ]; then
        echo "using chain of thought"
        python3 -u ./src/predict.py --db_root_path ${db_root_path} \
            --eval_path ${eval_path} --data_output_path ${data_kg_output_path} \
            --use_knowledge --chain_of_thought \
            --intelligence_url ${intelligence_url}
    else
        echo "not using chain of thought"
        python3 -u ./src/predict.py --db_root_path ${db_root_path} \
            --eval_path ${eval_path} --data_output_path ${data_kg_output_path} \
            --use_knowledge \
            --intelligence_url ${intelligence_url}
    fi
else
    if [ ${chain_of_thought} == 'True' ]; then
        echo "using chain of thought"
        python3 -u ./src/predict.py --db_root_path ${db_root_path} \
            --eval_path ${eval_path} --data_output_path ${data_output_path} \
            --chain_of_thought \
            --intelligence_url ${intelligence_url}
    else
        echo "not using chain of thought"
        python3 -u ./src/predict.py --db_root_path ${db_root_path} \
            --eval_path ${eval_path} --data_output_path ${data_output_path} \
            --intelligence_url ${intelligence_url}
    fi
fi
