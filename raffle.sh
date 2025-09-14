#!/usr/bin/env bash
# TASK-02 (Bash Scripting – 2): Raffle Draw dataset maker

set -euo pipefail
IFS=$'\n\t'

# --- get Student ID and output file ---
read -rp "Enter your Student ID (e.g., S298900): " student_id_raw
student_id="$(trim "$student_id_raw")"
student_id="${student_id// /}"          # remove any spaces inside too
outfile="${student_id}.txt"

# start fresh file
: > "$outfile"

echo "Welcome to the Raffle Draw Program."

# --- number of applicants 1..20 ---
num_people=""
while :; do
  read -rp "Enter the number of People participating: " num_people_raw
  num_people="$(trim "$num_people_raw")"

  # integer check
  if [[ ! "$num_people" =~ ^[0-9]+$ ]]; then
    echo "Number of people must be a whole number 1–20 (inclusive), Re-enter:"
    continue
  fi
  if (( num_people < 1 || num_people > 20 )); then
    echo "Number of people must be 1–20 (inclusive), Re-enter:"
    continue
  fi
  break
done

# --- collect each applicant ---
for ((i=1; i<=num_people; i++)); do
  echo "----------------------------------------"
  echo "Applicant $i of $num_people"

  # name: non-empty, <= 30 chars
  while :; do
    read -rp "Enter Name (max 30 chars): " name_raw
    name="$(trim "$name_raw")"
    name_len=${#name}
    if (( name_len == 0 )); then
      echo "Name cannot be empty - Re-enter (max 30 chars):"
      continue
    fi
    if (( name_len > 30 )); then
      echo "Name too Long - Re-enter (max 30 chars):"
      continue
    fi
    break
  done

  # state: anything except "Canberra" (case-insensitive)
  while :; do
    read -rp "Enter State (note: this program is for people outside 'Canberra'): " state_raw
    state="$(trim "$state_raw")"
    if [[ -z "$state" ]]; then
      echo "State cannot be empty - Re-enter State:"
      continue
    fi
    shopt -s nocasematch
    if [[ "$state" == "canberra" ]]; then
      echo "Canberra is not allowed at this moment - Re-enter State:"
      shopt -u nocasematch
      continue
    fi
    shopt -u nocasematch
    break
  done

  # append record to file
  {
    printf "%s\n" "$name"
    printf "%s\n" "$state"
    printf "%s\n" "------------"
  } >> "$outfile"
done

echo "ALL $num_people  Records have been Saved"
echo "Output file: $outfile"
