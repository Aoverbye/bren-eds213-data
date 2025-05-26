#!/bin/bash

DB_FILE="database.db"
CSV_FILE="query_comparison.csv"

SUBQUERY="SELECT Code FROM Species WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);"
OUTER_JOIN="SELECT Code FROM Bird_nests RIGHT JOIN Species ON Species = Code WHERE Nest_ID IS NULL;"
EXCEPT="SELECT Code FROM Species EXCEPT SELECT DISTINCT Species FROM Bird_nests;"

REPS=5000

# Clear output file
> "$CSV_FILE"

# Run all three timing tests
bash timer.sh subquery $REPS "$SUBQUERY" "$DB_FILE" "$CSV_FILE"
bash timer.sh outer_join $REPS "$OUTER_JOIN" "$DB_FILE" "$CSV_FILE"
bash timer.sh except $REPS "$EXCEPT" "$DB_FILE" "$CSV_FILE"
