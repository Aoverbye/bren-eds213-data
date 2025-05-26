#!/bin/bash

if [ $# -ne 5 ]; then
    echo "Usage: $0 label num_reps query db_file csv_file"
    exit 1
fi

label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

start_time=$SECONDS

for i in $(seq "$num_reps"); do
    duckdb "$db_file" -c "$query" > /dev/null 2>&1
done

end_time=$SECONDS
elapsed_time=$((end_time - start_time))

avg_time=$(echo "scale=6; $elapsed_time / $num_reps" | bc)

echo "$label,$avg_time" >> "$csv_file"
