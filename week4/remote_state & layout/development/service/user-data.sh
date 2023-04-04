#!/bin/bash

cat > index.html <<EOF
<html>
<head>
  <title>Hello, World!</title>
</head>
<body>
  <h1>Hello, World!</h1>
  <p>DB address: ${db_address}</p>
  <p>DB port: ${db_port}</p>
</body>
</html>
EOF

nohup busybox httpd -f -p \${server_port} &