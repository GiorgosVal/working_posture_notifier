#!/usr/bin/env bash
# crontab (At every 30th minute from 0 through 59 past every hour from 11 through 20 on every day-of-week from Monday through Friday)
# 0/30 11-20 * * 1-5

START_TIME_HRS='11'
START_TIME_MIN='00'
END_TIME_HRS='19'
END_TIME_MIN='30'
MINS_POSTURE_1='60'
MINS_POSTURE_2='30'
STARTING_POSTURE='1'
SWITCH_TO_POSTURE_1_MSG='Please sit down'
SWITCH_TO_POSTURE_2_MSG='Please stand up'


CURRENT_TIME_EPOCH="$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")"
echo "Current date in epoch is $CURRENT_TIME_EPOCH"
START_TIME_EPOCH="$(date -j -f "%a %b %d %T %Z %Y" "`date -v "${START_TIME_HRS}H" -v "${START_TIME_MIN}M" -v '0S'`" "+%s")"
echo "Start date in epoch is $START_TIME_EPOCH"
END_TIME_EPOCH="$(date -j -f "%a %b %d %T %Z %Y" "`date -v "${END_TIME_HRS}H" -v "${END_TIME_MIN}M" -v '0S'`" "+%s")"
echo "End date in epoch is $END_TIME_EPOCH"

if [[ "${START_TIME_EPOCH}" -le "${CURRENT_TIME_EPOCH}" ]] && [[ "${CURRENT_TIME_EPOCH}" -le "${END_TIME_EPOCH}" ]]
then
  echo "Current time is between working range"
  WORKING_MINUTES=$(((CURRENT_TIME_EPOCH-START_TIME_EPOCH)/60))
  echo "Working minutes $WORKING_MINUTES"
  FULL_CYCLE_MINS=$((MINS_POSTURE_1+MINS_POSTURE_2))
  echo "Full cycle minutes $FULL_CYCLE_MINS"
  CURRENT_TO_FULL_CYCLE_RELATION=$((WORKING_MINUTES%FULL_CYCLE_MINS))
  echo "Mod $CURRENT_TO_FULL_CYCLE_RELATION"

  if [[ "${STARTING_POSTURE}" -eq 1 ]]
  then
    STARTING_POSTURE_MINS="${MINS_POSTURE_1}"
    STARTING_POSTURE_MSG="${SWITCH_TO_POSTURE_1_MSG}"
    NEXT_POSTURE_MSG="${SWITCH_TO_POSTURE_2_MSG}"
  else
    STARTING_POSTURE_MINS="${MINS_POSTURE_2}"
    STARTING_POSTURE_MSG="${SWITCH_TO_POSTURE_2_MSG}"
    NEXT_POSTURE_MSG="${SWITCH_TO_POSTURE_1_MSG}"
  fi
  echo "Starting posture minutes $STARTING_POSTURE_MINS"
  echo "Starting posture message $STARTING_POSTURE_MSG"
  echo "Next posture message $NEXT_POSTURE_MSG"

  if [[ $CURRENT_TO_FULL_CYCLE_RELATION -eq $STARTING_POSTURE_MINS ]]
  then
    echo "Should switch to next posture"
    say "$NEXT_POSTURE_MSG" -v "Karen"
  elif [[ $CURRENT_TO_FULL_CYCLE_RELATION -eq 0 ]]
  then
    echo "Should switch to starting posture"
    say "$STARTING_POSTURE_MSG" -v "Karen"
  else
    echo "Should not change posture"
  fi
else
  echo "Outside working hours"
fi