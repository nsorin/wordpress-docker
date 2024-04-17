#!/bin/bash

# Read .env file and export its content
set -a
source .env
set +a

echo "Creating local directories..."
mkdir -p wordpress-data wordpress-data-backup db-data db-data-backup db-initial-data

echo "Deleting old backup..."
rm -rf wordpress-data-backup/*
rm -rf db-data-backup/*

echo "Backing up wordpress-data and db-data..."
mv wordpress-data/* wordpress-data-backup/
mv db-data/* db-data-backup/

echo "Downloading files from $SERVER_HOST:$SERVER_PATH..."
scp -r -P $SERVER_PORT $SERVER_USER@$SERVER_HOST:$SERVER_PATH/. wordpress-data

echo "Setting ownership of webserver files..."
chown -R www-data wordpress-data/.

echo "DONE - Don't forget to check and fix wordpress-data/wp-config.php"