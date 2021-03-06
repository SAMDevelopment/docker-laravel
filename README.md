![Laraduck](http://samdevelopment.nl/assets/laraduck-logo.png)

[Github](https://github.com/SAMDevelopment/laraduck) | [Docker hub](https://hub.docker.com/r/samdevelopment/laraduck/)

Laraduck is a simple nginx and php-fpm container to run php applications (such as Laravel). You can combine this with your own (or official) containers: MySQL, Redis, etc.

## Latest Tags
- [`1.3.2`, `1.3`, `1`, `latest` *(Dockerfile)*](https://github.com/SAMDevelopment/laraduck/blob/master/src/Dockerfile)

For version changes checkout the [Github releases](https://github.com/SAMDevelopment/laraduck/releases).

## Setup
The only step for setup is mounting your php application to `/opt/app`. The container will start your application from the `/opt/app/public` directory.

### Installing Laravel
To install Laravel into an empty repo, run the following command from that repo:

```bash
docker run --rm -v $(pwd):/opt/app samdevelopment/laraduck composer create-project --prefer-dist laravel/laravel .
```

## Laravel on Linux
Don't forget to set the correct permissions on Linux. (commands run from Laravel root dir)

- `sudo chown -R $(id -u):$(id -g) .`
- `sudo chown -R www-data:www-data ./storage/ ./bootstrap/cache/`

## Configuration / Environment
There are several environment variables available to customize your setup.

| Variable         | Default       | Description                                                                                    |
|------------------|---------------|------------------------------------------------------------------------------------------------|
| `APP_PUBLIC_DIR` | `public`      | Choose the directory that serves as the entrypoint for php. Use `.` to set the root directory. |
| `APP_DOMAIN`     | `localhost`   | Used to set the domain in the nginx configuration.                                             |
| `APP_ENV`        | `development` | Change the Application Environment. Mainly used to enable or disable xdebug.                   |
| `APP_LOG_LEVEL`  | `notice`      | Used to set the corresponding configuration value for php-fpm.                                 |

## Modules & Packages
There are several modules and packages installed to provide a complete development environment.

### php-fpm

`cli`, `curl`, `gd`, `mbstring`, `mcrypt`, `mysql`, `sqlite3`, `xml`

### Composer
The Prestissimo Composer plugin is installed. This plugin enables parallel downloading for Composer.

### SSL (Snakeoil)
Snakeoil is installed to easily provide self signed certificates through nginx. No setup is required.

## Licence
Laraduck is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
