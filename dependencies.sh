#!/bin/sh

sudo apt-get update
sudo apt-get install -y software-properties-common python-software-properties build-essential libssl-dev

# nginx
sudo apt-get install -y nginx

#git
sudo apt-get install -y git

#postgre
sudo apt-get install -y postgresql postgresql-contrib postgis
sudo apt-get update

# Elastic Search
if ! [ -d /etc/elasticsearch ]; then
   sudo apt-get install -y openjdk-7-jre
   sudo add-apt-repository -y ppa:webupd8team/java
   sudo apt-get update
   wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
   sudo dpkg -i elasticsearch-1.7.2.deb
   sudo update-rc.d elasticsearch defaults
   rm elasticsearch-1.7.2.deb
else
  echo "Elastic Search already installed"
fi

# Redis
if ! [ -d /etc/redis ]; then
  sudo apt-get install -y tcl8.5
  wget http://download.redis.io/releases/redis-stable.tar.gz
  tar xzf redis-stable.tar.gz
  cd redis-stable
  make
  make test
  sudo make install
  sudo ./utils/install_server.sh
  sudo update-rc.d redis_6379 defaults
  cd ../
  rm -rf redis-stable redis-stable.tar.gz
else
  echo "Redis already installed"
fi

# NVM
if [ -d $HOME/.nvm ]
then
  echo "NVM Already installed"
else
  if ! [ -e $HOME/.zshrc ] && ! [ -e $HOME/.bashrc ]; then
    touch $HOME/.bashrc
  fi

  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

fi

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install v6.9.1
nvm use default

# Node dependencies
npm install node-gyp
npm install -g grunt-cli
npm install -g bower
