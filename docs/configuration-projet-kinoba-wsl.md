# Configuration les projets Kinoba sur WSL

## Prérequis
- Avoir WSL installé sur la machine
## Clonage du repo
```warning
Avant de cloner le repo, aller sur WSL et réglé les EOL sur `LF` avec `git config --global core.autocrlf false`. Autrement les scripts ne s'exécuteront pas !
```

Cloner le repo sur le système de fichier WSL, ici par exemple :
```shell
# sous windows via Github Desktop
\\wsl.localhost\Ubuntu-20.04\home\remi\web\phoenix-contact\

# depuis le shell WSL
~/web/phoenix-contact/
/home/remi/web/phoenix-contact/
```

```note
Il est possible de cloner le repo sur le système de fichier Windows classique (ie. `C:\web\...`) mais l'exécution sera beaucoup plus lente depuis WSL (`/mnt/c/web/`) et le hot reload de webpack ne fonctionnera pas !*
```
## Ruby, rbenv, bundler, foreman...
```shell
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
```

```shell
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
```

```shell
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
```

```shell
rbenv install 3.0.3
rbenv global 3.0.3
gem install bundler
gem install foreman
rbenv rehash
```

```shell
sudo apt-get install ffmpeg imagemagick
```
## Postgresql
```shell
sudo apt install postgresql postgresql-contrib
sudo apt-get install libpq-dev
sudo service postgresql restart
```
### Création d'un utilisateur `developer`/`password` avec les droits `CREATEDB`
```shell
sudo -i -u postgres
CREATE USER developer WITH PASSWORD 'password';
ALTER USER developer WITH CREATEDB;
```
## Redis
```shell
sudo apt install redis-server
sudo service redis-server start
```
## Nvm (node.js)
```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
# nvm list-remote
nvm install lts/fermium # v14.19.0
```
## Yarn
```shell
npm install -g yarn
```
## Dépendances du projet

Donner les droits en exécution pour tous les fichiers des dossiers du projet
```shell
chmod +x -R ~/web/phoenix-contact/
```

Installer les dépendances et seed la DB
```shell
./scripts/reset-db
```
## Lancer le serveur local
```shell
./scripts/dev
```
Accès au site via `http://localhost:5200`