#!/bin/bash
is_valid() {
    local num=$1
    if ! [[ $num =~ ^[0-9]+$ ]]; then
        echo "Error: Number should only contain digits."
        exit 1
    fi
    if [[ ${#num} -ne 4 ]]; then
        echo "Error: Number should be exactly 4 digits long."
        exit 1
    fi
    if [[ ${num:0:1} == ${num:1:1} && ${num:0:1} == ${num:2:1} && ${num:0:1} == ${num:3:1} ]]; then
        echo "Error: Number has all identical digits."
        exit 1
    fi
    return 0
}

kaprekar() {
    local num=$1
    local count=0

    while [[ $num -ne 6174 ]]; do
        digits=()
        for ((i = 0; i < ${#num}; i++)); do
            digits+=("${num:i:1}")
        done
        num_desc=$(printf "%s\n" "${digits[@]}" | sort -r | tr -d '\n')
        num_asc=$(printf "%s\n" "${digits[@]}" | sort | tr -d '\n')
        num=$((10#$num_desc - 10#$num_asc))
        ((count++))
        echo "Iteration $count: $num"
        num=$(printf "%04d" "$num")
    done
    echo "No. of iterations to reach 6174 : $count"
}
read -p "Enter a 4-digit number: " num
if is_valid "$num"; then
    kaprekar "$num"
fi


