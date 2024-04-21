#!/bin/bash

rm -rf db-data/*
rm -rf wordpress-data
mkdir wordpress-data
docker compose build wordpress --no-cache