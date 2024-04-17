FROM wordpress:6.5.2-php8.2

ARG SERVER_HOST
ARG SERVER_PORT
ARG SERVER_USER
ARG SERVER_PATH

RUN set -ex; \
	apt-get update; \
	apt-get install -y openssh-client;

RUN rm -rf /var/www/html/* /var/www/html/.htaccess;

RUN --mount=type=secret,id=ssh_key,required scp -i /run/secrets/ssh_key -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r -P $SERVER_PORT $SERVER_USER@$SERVER_HOST:$SERVER_PATH/. /var/www/html/

ADD wp-config.php /var/www/html/

RUN chown -R www-data:www-data /var/www/html/.



