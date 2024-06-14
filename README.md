# Container build
podman build -t scrapegraphai .

# Local dev
podman run -v $(pwd)/src:/home/app/src -it scrapegraphai /bin/bash

# Installing dependencies
podman run --user root -v $(pwd):/home/app -it scrapegraphai pipenv install requests
