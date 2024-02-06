#!/usr/bin/env bash

appName="synctv"
builtAt="$(date +'%F %T %z')"
goVersion=$(go version | awk '{print $3}')
gitAuthor="SyncTV <pyh1670605849@gmail.com>"
gitCommit=$(git log --pretty=format:"%h" -1)
version=$(git describe --long --tags --dirty --always)
webVersion=$(wget -qO- -t1 -T2 "https://api.github.com/repos/synctv-org/synctv-web/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

ldflags="\
-w -s \
-X 'github.com/synctv-org/synctv/internal/conf.BuiltAt=$builtAt' \
-X 'github.com/synctv-org/synctv/internal/conf.GoVersion=$goVersion' \
-X 'github.com/synctv-org/synctv/internal/conf.GitAuthor=$gitAuthor' \
-X 'github.com/synctv-org/synctv/internal/conf.GitCommit=$gitCommit' \
-X 'github.com/synctv-org/synctv/internal/conf.Version=$version' \
-X 'github.com/synctv-org/synctv/internal/conf.WebVersion=$webVersion' \
"

go build -ldflags="$ldflags" -tags=jsoniter .
