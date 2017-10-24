#!/usr/bin/env bash
set -e

#temp fix
sleep 10

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
	if [ `ls -A /usr/src/microweber/config | wc -m` == "0" ]; then
	    unzip microweber.zip 'config/*' -d /usr/src/microweber
	    chown -R www-data:www-data /usr/src/microweber/config
	fi

	if [ `ls -A /usr/src/microweber/userfiles | wc -m` == "0" ]; then
	    unzip microweber.zip 'userfiles/*' -d /usr/src/microweber
	    chown -R www-data:www-data /usr/src/microweber/userfiles
	fi

	if [ -f "/usr/src/microweber/config/microweber.php" ]
	then
		echo "CMS is installed, skipping"
	else
		sudo -u www-data php /usr/src/microweber/artisan microweber:install
		chown -R www-data:www-data /usr/src/microweber/storage
	fi
fi

exec "$@"
