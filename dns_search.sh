#!/bin/bash

# Check if all three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 start stop string"
    exit 1
fi

# Assign arguments to variables
start=$1
stop=$2
string=$3

digits=${string//[^#]/} # collect the '#' characters
num_hashes=${#digits}   # get length of the counted string

echo "Running using search parameters: " $start $stop $string $digits $num_hashes

# Function to format number with leading zeros
# TODO - optional number of 0's and none.
format_number() {
    local num=$1
    local digits=$2
    printf "%0${digits}d" $num
}

# Iterate from start to stop
for (( i=start; i<=stop; i++ )); do
    # Format the current number with leading zeros
    formatted_number=$(format_number $i $num_hashes)

    # Replace ## with the current number
    replaced_string="${string//$digits/$formatted_number}"
    
    # Perform nslookup
    echo "Performing nslookup for: $replaced_string"
    nslookup "$replaced_string"
    echo "--------------------------------------------------"
done
