# Wordpress-Docker

A set of utilities to quickly clone a remotely hosted wordpress website and run it in docker to experiment on it locally.

## Prerequisites

- A working docker and docker-compose installation
- An SSH key whose public counterpart has been registered on the server where wordpress is hosted

## How to run

- Copy `.env.example` as `.env` and fill in the blanks (this should point to the location where wordpress is hosted)
    - SERVER_HOST: The domain name or IP Address of your webserver
    - SERVER_PORT: The port which is open to ssh connections on your webserver, typically 22
    - SERVER_USER: The user on the webserver
    - SERVER_PATH: The path on the webserver where the website is located
    - SSH_KEY_PATH: The path to your private SSH key on your local machine. This is the key you normally use to connect to the webserver via SSH on your machine.
- Export your productive database in an SQL file and put it in `db-initial-data` (TODO: Automate this process)
- Copy your remote `wp-config.php` in the `wordpress` directory and set the following values:
```
define( 'DB_NAME', 'wpdb' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'db' );

define('FS_METHOD', 'direct');
define( 'WP_SITEURL', 'http://localhost' );
define( 'WP_HOME',    'http://localhost' );
```
- Also check for anything that would not work locally, for instance absolute paths:
```
/** Before **/
define( 'WPCACHEHOME', '/some/absolute/path/wp-content/plugins/wp-super-cache/' );

/** After **/
define( 'WPCACHEHOME', '/var/www/html/wp-content/plugins/wp-super-cache/' );
```
- Run `docker compose up`

The build process will:
- Setup a new MySQL Database and import the data from `db-initial-data`    
- Download your website's entire source code in the wordpress service, then replace the config with the local one. This can take a long time depending on the size of your website and the speed of your internet connection.

Once everything is up and running, the website should be available at `http://localhost` and phpMyAdmin at `http://localhost:8080`. Use the usual admin account credentials to log in. Any change to the local copy of the website will be saved locally.

To reimport the source code from the webserver, delete the content of `wordpress-data` and use `docker compose build wordpress --no-cache`. Alternatively, simply run `rebuild-from-remote.sh` (as `sudo` if needed).