#!/usr/bin/env bash
sudo mkdir -p /data/web_static/releases/test
sudo mkdir -p /data/web_static/shared/
sudo touch /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu. /data
sudo sh -c "echo '<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>' > /data/web_static/releases/test/index.html"
sudo sed  -ie 's|^\t}|\t}\n\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n\t}|' /etc/nginx/sites-available/default
sudo service nginx restart
