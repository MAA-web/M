#!/bin/bash

dates=(

# M - 11,12,13,14,15,16,17,19,27,28 jan 2 Feb   11 x 50 = 550
"2026-01-11"
"2026-01-12"
"2026-01-13"
"2026-01-14"
"2026-01-15"
"2026-01-16"
"2026-01-17"
"2026-01-19"
"2026-01-27"
"2026-01-28"
# feb
"2026-02-02"

# # I - 22,28 Feb, 1,2,3,4,5,6,7,8,14 Mar
# "2026-02-22"
# "2026-02-28"
# # mar
# "2026-03-01"
# "2026-03-02"
# "2026-03-03"
# "2026-03-04"
# "2026-03-05"
# "2026-03-06"
# "2026-03-07"
# "2026-03-08"
# "2026-03-14"

# # A - 22,23,24,25,26,27,28,30 Mar, 2,7,9,15,16,23,24,25 Apr
# "2026-03-22"
# "2026-03-23"
# "2026-03-24"
# "2026-03-25"
# "2026-03-26"
# "2026-03-27"
# "2026-03-28"
# "2026-03-30"
# # apr
# "2026-04-02"
# "2026-04-07"
# "2026-04-09"
# "2026-04-15"
# "2026-04-16"
# "2026-04-23"
# "2026-04-24"
# "2026-04-25"

# # N - 3,4,5,6,7,8,9,11,19,20,21,29,31 May 1,2,3,4,5,6 jun 
# "2026-05-03"
# "2026-05-04"
# "2026-05-05"
# "2026-05-06"
# "2026-05-07"
# "2026-05-08"
# "2026-05-09"
# "2026-05-11"
# "2026-05-19"
# "2026-05-20"
# "2026-05-21"
# "2026-05-29"
# "2026-05-31"
# # jun
# "2026-06-01"
# "2026-06-02"
# "2026-06-03"
# "2026-06-04"
# "2026-06-05"
# "2026-06-06"
)

for date in "${dates[@]}"
do
  # random number between 30 and 40 commits
  num_commits=50

  # start time: 11:29:00
  base_hour=11
  base_minute=29
  base_second=0

  for ((i=0; i<num_commits; i++))
  do
    # increment time by random 20–120 seconds each commit
    increment=$((20 + RANDOM % 101))
    base_second=$((base_second + increment))

    # normalize time
    base_minute=$((base_minute + base_second / 60))
    base_second=$((base_second % 60))
    base_hour=$((base_hour + base_minute / 60))
    base_minute=$((base_minute % 60))

    timestamp=$(printf "%s %02d:%02d:%02d" "$date" "$base_hour" "$base_minute" "$base_second")

    echo "$date commit $((i+1))" >> commits.txt
    git add commits.txt

    GIT_AUTHOR_DATE="$timestamp" \
    GIT_COMMITTER_DATE="$timestamp" \
    git commit -m "Commit $((i+1)) for $date"
  done
done
