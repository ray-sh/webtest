 #!/bin/sh
 HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get
 cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode
 cd ..