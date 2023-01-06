#!/bin/bash

set -x

sudo docker pull --platform=linux/arm/v6 maven:3-adoptopenjdk-11
sudo docker pull --platform=linux/arm/v6 adoptopenjdk:11-jre
