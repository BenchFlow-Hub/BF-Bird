from benchflow import BaseBench
from benchflow.schemas import BenchArgs
from benchflow.schemas import BenchmarkResult
from typing import Dict, Any
import os
import json

class BirdDevBench(BaseBench):
    def __init__(self):
        super().__init__()

    def get_args(self, task_id: str) -> BenchArgs:
        arguments = {
            "required": [],
            "optional": [
                {"CHAIN_OF_THOUGHT": "True"},
                {"USE_KNOWLEDGE": "True"}
            ],
        }
        return BenchArgs(arguments)
    
    def get_image_name(self) -> str:
        """
        Return the Docker image name for running the WebArena benchmark.
        """
        return "kirk2000/benchflow:bird-dev-v1"
    
    def get_results_dir_in_container(self) -> str:
        """
        Return the directory inside the container where the benchmark results will be stored.
        """
        return "/app/result"
    
    def get_log_files_dir_in_container(self) -> str:
        """
        Return the directory inside the container where the log files will be stored.
        """
        return "/app/prediction_result"
    
    def get_result(self, task_id: str) -> BenchmarkResult:
        """
        Read and parse the benchmark result from the log files.
        
        This method expects a file named 'log_files.txt' in the results directory.
        It then reads the content of each log file listed in 'log_files.txt',
        aggregates the log output, and extracts the average score and pass status.
        """
        results_txt = os.path.join(self.results_dir, "evaluation_result_ex.json")
        if not os.path.exists(results_txt):
            return BenchmarkResult(task_id=task_id, is_resolved=False, metrics={"score": 0},log={"error": "No results found"}, other={})
        
        with open(results_txt, 'r') as f:
            result = json.load(f)
        
        is_resolved = True
        metrics = result["accuracy"]
        metrics = {"simple_task_accuracy": metrics["simple"], "moderate_task_accuracy": metrics["moderate"], "challenging_task_accuracy": metrics["challenging"], "total_task_accuracy": metrics["total"]}
        paths = [os.path.join(self.log_files_dir, "turbo_output_kg", "predict_dev.json"), 
                 os.path.join(self.log_files_dir, "turbo_output", "predict_dev.json"),
                 os.path.join(self.log_files_dir, "turbo_output_kg", "predict_dev_cot.json"),
                 os.path.join(self.log_files_dir, "turbo_output", "predict_dev_cot.json"),
                 ]
        existing_paths = [path for path in paths if os.path.exists(path)]
        if len(existing_paths) != 1:
            return BenchmarkResult(task_id=task_id, is_resolved=False, metrics={"score": 0},log={"error": f"no valid log file found, find {len(existing_paths)} log files"}, other={})
        log_content_dir = existing_paths[0]
        log_content = ""
        with open(log_content_dir, 'r') as f:
            log_content += f.read()
        return BenchmarkResult(task_id=task_id, is_resolved=is_resolved, metrics=metrics, log={"details": log_content}, other={})
    
    def get_all_tasks(self, split: str) -> Dict[str, Any]:
        """
        Return a dictionary with all task IDs and an optional error message.
        """
        return {"task_ids": ["all"], "error_message": None}
    
    def cleanup(self):
        """
        Clean up benchmark resources by removing the local results and log files directories.
        """
        pass

