#!/bin/bash

while getopts "c:b:" opt; do
  case $opt in
    c)
      catapults="$OPTARG"
      ;;
    b)
      battalions="$OPTARG"
      ;;
  esac
done

IFS=' ' read -r -a battalion_array <<< "$battalions"
unset IFS
IFS=$'\n' battalion_array_sort=($(sort -nr <<<"${battalion_array[*]}"))
unset IFS

destroyed=0

while [ "$catapults" -gt 0 ] && [ ${#battalion_array_sort[@]} -gt 0 ]; do
  battalion=${battalion_array_sort[0]}

  if [ "$catapults" -ge "$battalion" ]; then
    catapults=$((catapults - battalion))
    destroyed=$((destroyed + 1))
  elif [ ${#battalion_array_sort[@]} -eq 1 ]; then
    break
  fi

  battalion_array_sort=("${battalion_array_sort[@]:1}") 
done

echo "$destroyed"


