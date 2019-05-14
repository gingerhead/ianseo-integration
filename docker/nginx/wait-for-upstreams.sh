#!/bin/bash
cmdname=$(basename $0)

echoerr() { if [[ $QUIET -ne 1 ]]; then echo "$@" 1>&2; fi }


TIMEOUT=20
QUIET=0
CLI=("$@")

wait_for()
{
    local HOST=$1
    local PORT=$2
    local RESULT=1

    if [[ $TIMEOUT -gt 0 ]]; then
        echoerr "$cmdname: waiting $TIMEOUT seconds for $HOST:$PORT"
    else
        echoerr "$cmdname: waiting for $HOST:$PORT without a timeout"
    fi
    local start_ts=$(date +%s)
    while :
    do
        if [[ $ISBUSY -eq 1 ]]; then
            nc -z $HOST $PORT
            result=$?
        else
            (echo > /dev/tcp/$HOST/$PORT) >/dev/null 2>&1
            result=$?
        fi
        if [[ $result -eq 0 ]]; then
            end_ts=$(date +%s)
            echoerr "$cmdname: $HOST:$PORT is available after $((end_ts - start_ts)) seconds"
            break
        fi

        local cur_date=$(date +%s)
        if [[ $((cur_date - start_ts)) -gt $TIMEOUT ]]; then
            echoerr "$cmdname: timeout occurred after waiting $TIMEOUT seconds for $HOST:$PORT"
            break
        fi

        sleep 1
    done
    return $result
}

TIMEOUT_PATH=$(realpath $(which timeout))
if [[ $TIMEOUT_PATH =~ "busybox" ]]; then
        ISBUSY=1
        BUSYTIMEFLAG="-t"
else
        ISBUSY=0
        BUSYTIMEFLAG=""
fi

RESULT=0

wait_for ianseo 8080
if [[ $? -ne 0 ]]; then
    RESULT=1
fi


if [[ $CLI != "" ]]; then
    exec "${CLI[@]}"
else
    exit $RESULT
fi
