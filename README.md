# olympus

## usage
```shell script
git submodule init
git submodule update
cp .env.dist .env
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
```

## services
- [aphrodite](http://localhost:8083)
- [delphi](http://localhost:8085)
- [netdata](http://localhost:19999/#menu_apache_apollo_submenu_requests)

