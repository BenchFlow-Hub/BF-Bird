#!/bin/bash

cot=$1
use_knowledge=$2

num_cpus=16
meta_time_out=30.0
mode_predict='gpt'
db_root_path='./data/dev_databases/'
diff_json_path='./data/dev.json'
predicted_sql_path_kg='./exp_result/turbo_output_kg/'
predicted_sql_path='./exp_result/turbo_output/'
ground_truth_path='./data/'

if [ ${use_knowledge} == 'True' ]; then
    if [ ${cot} == 'True' ]; then
        echo '''starting to compare with knowledge for ex'''
        python3 -u ./src/evaluation.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path_kg} \
        --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
        --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out} --cot
    else
        python3 -u ./src/evaluation.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path_kg} \
        --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
        --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out} 
    fi
else
    if [ ${cot} == 'True' ]; then
        echo '''starting to compare without knowledge for ex'''
        python3 -u ./src/evaluation.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path} \
        --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
        --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out} --cot
    else
        echo '''starting to compare without knowledge for ex'''
        python3 -u ./src/evaluation.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path} \
        --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
        --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out}
    fi
fi

# if [ ${use_knowledge} == 'True' ]; then
#     if [ ${cot} == 'True' ]; then
#         echo '''starting to compare with knowledge for ves'''
#         python3 -u ./src/evaluation_ves.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path_kg} \
#         --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
#         --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out} --cot
#     else
#         echo '''starting to compare with knowledge for ves'''
#         python3 -u ./src/evaluation_ves.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path_kg} \
#         --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
#         --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out}
#     fi  
# else
#     if [ ${cot} == 'True' ]; then
#         echo '''starting to compare without knowledge for ves'''
#         python3 -u ./src/evaluation_ves.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path} \
#         --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
#         --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out} --cot
#     else
#         echo '''starting to compare without knowledge for ves'''
#         python3 -u ./src/evaluation_ves.py --db_root_path ${db_root_path} --predicted_sql_path ${predicted_sql_path} \
#         --ground_truth_path ${ground_truth_path} --num_cpus ${num_cpus} --mode_predict ${mode_predict} \
#         --diff_json_path ${diff_json_path} --meta_time_out ${meta_time_out}
#     fi
# fi
