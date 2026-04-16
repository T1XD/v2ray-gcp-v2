#!/bin/sh

# Start health responder with 503 Service Unavailable status
(
  while true; do
    echo -e "HTTP/1.1 503 Service Unavailable\r\nContent-Type: text/plain\r\nContent-Length: 21\r\nConnection: close\r\n\r\nService Unavailable" | nc -l -p 80 -q 1 2>/dev/null
  done
) &

# Start original health process
/health &

# Start Xray
/usr/bin/xray run -c /etc/xray/config.json
