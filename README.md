# MyBackup

**Disclaimer: there are no warranty of service!**

## How to use

Backup is done in bind mount a volume to externalize it.

Backup is configurated using environment variable sent to the container at rutime.

- MYSQL_ROOT_PASSWORD (to give the root password)
- MYSQL_SCHEMA (what schema should be dumped)
- MYSQL_SERVICE_NAME (whats the name of the container or service running the database)

On top of these you'll probably want to specify the docker network in which your db container can be reached.

I.E.:

```docker run -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_SCHEMA=mydb -e MYSQL_SERVICE_NAME=mydbcontainer --network docker_net_db -v $(pwd):/backup yceos/mybackup:stable```

## Other info

This may evolve in the future, although I won't be taking feature requests, I'll gladly take feedback.