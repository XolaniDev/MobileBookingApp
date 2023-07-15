#!/bin/bash

PORT=4040
fuser -k 4040/tcp
cd build/web/
python3 -m http.server $PORT
