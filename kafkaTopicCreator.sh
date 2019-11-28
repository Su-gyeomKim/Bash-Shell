#!/bin/bash

command='kafka-topics --create --zookeeper bd-dev01:2181 --replication-factor 2 --partitions 4 --topic'


$command sise-rt-price
$command sise-rt-tick
$command tr-bt
$command tr-loss
$command tr-rt
$command tr-rt-news
$command tr-rt-stock
$command tr-ss
$command weblog

kafka-topics --zookeeper bd-dev01:2181 --list
