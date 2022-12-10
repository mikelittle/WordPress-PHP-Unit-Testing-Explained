#!/bin/bash

# Fail on any error.
set -e

cd bylines

# Install Composer dependencies.
echo -e "Step 1: Install Composer dependencies"
composer install --no-suggest

# Create the test database.
echo -e "Step 2: Create the test database"
echo -e " * Creating database 'byline_tests' (if it's not already there)"
mysql -e "CREATE DATABASE IF NOT EXISTS \`byline_tests\`"
echo -e " * Granting the wp user priviledges to the 'byline_tests' database"
mysql -e "CREATE USER IF NOT EXISTS wp@localhost IDENTIFIED WITH mysql_native_password BY 'wp';"
mysql -e "GRANT ALL PRIVILEGES ON \`byline_tests\`.* TO wp@localhost;"
echo -e " * DB operations done."

# Do a test run.
echo -e "Step 3: Do a test run"
composer test

cd ..
