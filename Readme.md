# Local Wordpress development environment with Docker

A set of utilities to quickly clone a remotely hosted wordpress website and run it in docker for local development.

## Prerequisites

- A working docker and docker-compose installation
- An SSH connection to the server where the wordpress website is hosted with the necessary credentials

## How to run

- Copy `.env.example` as `.env` and fill in the blanks (this should point to the location where wordpress is hosted)
- Run `pull-from-server.sh` to create the directory structure and download the website from the server
- Export your productive database in an SQL file and put it in `db-initial-data`
- Check the `wordpress-data/wp-config.php` file and replace the following values:
```
define( 'DB_NAME', 'wpdb' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'db' );
```
- Also check for anything that would not work locally, for instance absolute paths:
```
/** Before **/
define( 'WPCACHEHOME', '/some/absolute/path/wp-content/plugins/wp-super-cache/' );

/** After **/
define( 'WPCACHEHOME', '/var/www/html/wp-content/plugins/wp-super-cache/' );
```
- Run `docker compose up`

The website should be available at `http://localhost` and phpMyAdmin at `http://localhost:8080`. Any change to the local copy of the website will be saved locally.