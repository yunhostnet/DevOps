#!/bin/bash
#Time 2017-02-06 09:23
#Author Yo
#Control redis
CONF=/etc/redis.conf
COMMDDIR=/usr/local/redis/bin
function Help()
{
cat <<_ACEOF
control redis bash script.
Usage $0 [OPTION]... [VAR=VALUE]...
        help            display this help and exit
        start           start redis with /etc/redis.conf
        stop            stop redis
_ACEOF
}
function Start()
{
    if [ `ps aux |grep redis-server |wc -l` -eq 2 ];then
        echo redis_online
        exit 2
    fi
    ${COMMDDIR}/redis-server ${CONF}
}
function Stop()
{
    if [ `netstat -tln |grep 6379 |wc -l` -eq 0 ];then
        echo redis_ofline
        exit 2
    fi
    ${COMMDDIR}/redis-cli -h 127.0.0.1 -p 6379 shutdown
}
case "$1" in
    "start")
        Start
        ;;
    "stop")
        Stop
        ;;
        *)
        Help
        ;;
esac