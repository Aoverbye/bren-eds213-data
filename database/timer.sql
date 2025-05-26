#!/bin/bash

# Check if all arguments are provided
if [ $# -ne 5 ]; then
    echo "Usage: $0 label num_reps query db_file csv_file"
    exit 1
fi

# Store arguments in variables
label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# Get the start time
start_time=$SECONDS

# Run the query the specified number of times
for i in $(seq $num_reps); do
    duckdb "$db_file" -c "$query" > /dev/null 2>&1
done

# Calculate elapsed time
elapsed=$(( SECONDS - start_time ))

# Calculate average time per query (using bc for floating point division)
avg_time=$(echo "scale=6; $elapsed / $num_reps" | bc)

# Append the result to the CSV file
echo "$label,$avg_time" >> "$csv_file"

echo "Completed $num_reps repetitions in $elapsed seconds"
echo "Average time per query: $avg_time seconds"
echo "Results appended to $csv_file"

chmod +x query_timer.sh