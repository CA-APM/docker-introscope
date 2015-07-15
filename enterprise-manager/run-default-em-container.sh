#!/bin/sh
# This runs a container in default mode. Note that this expects that the sieglstefan/introscope-postgres already is started. If you can you should rather use docker-compose (there are some scripts at top level).

docker run -d --name introscope-em -e HEAP="2048m" -p 5001:5001 -p 8081:8081 -v /Users/grogu01/git/docker-introscope/transfer/xmltv:/transfer/xmltv -v /Users/grogu01/git/docker-introscope/transfer/modules:/transfer/modules --link introscope-db:db ggrossbe/introscope-em-10.0
