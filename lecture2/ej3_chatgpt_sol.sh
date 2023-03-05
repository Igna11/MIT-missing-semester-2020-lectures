#!/bin/bash

run_count=0
success_count=0
failure_count=0

while true; do
  run_count=$((run_count+1))
  echo "Running script, attempt #$run_count..."
  
  # Run the script and capture its output
  output=$(./random_bug.sh 2>&1)
  
  # Check the exit status of the script
  if [ $? -ne 0 ]; then
    # Script failed, increment failure count
    failure_count=$((failure_count+1))
    echo "Script failed on attempt #$run_count."
    
    # Save the output to a file
    echo "$output" > "output_failure_$run_count.txt"
    echo "Output saved to output_failure_$run_count.txt."
  else
    # Script succeeded, increment success count
    success_count=$((success_count+1))
    echo "Script succeeded on attempt #$run_count."
    
    # Save the output to a file
    echo "run_count $run_count: $output" >> "output_success.txt"
    echo "Output saved to output_success.txt."
  fi
  
  # Check if we have reached a failure run
  if [ $failure_count -gt 0 ]; then
    # Print final results
    echo ""
    echo "Script failed after $run_count runs."
    echo "Success count: $success_count"
    echo "Failure count: $failure_count"
    echo ""
    
    # Print the output of the last failed run
    cat "output_failure_$run_count.txt"
    exit 1
  fi
done