# Configuration les projets Kinoba sur WSL

## Prérequis
Avoir WSL installé sur la machine

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

## Transfert des ports WSL vers Windows pour accès depuis LAN
Créer un fichier PS1 :
```powershell
# Récupérer l'adresse IP de la machine Linux WSL
$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
  $remoteport = $matches[0];
} else{
  echo "Le script va se fermer car l'adresse IP de la machine WSL 2 est introuvable.";
  exit;
}

# Tous les ports forwarder vers votre machine WSL 2
$ports=@(80,443,3000,5000,5100,5200); #80,443,5000,5100 ne sont pas nécessaires dans le cas de pxf

# Adresse IP sur laquelle écouter au niveau de la machine Windows 10
$addr='0.0.0.0';
$ports_a = $ports -join ",";

# Supprimer la règle de pare-feu "WSL 2 Firewall Unlock"
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' ";

# Créer les règles de pare-feu (flux entrant et sortant) avec chacun des ports de $ports
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";

# Créer les règles de redirection de ports pour chacun des ports ($ports)
for( $i = 0; $i -lt $ports.length; $i++ ){
  $port = $ports[$i];
  iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
  iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}
```
Et le lancer depuis un terminal (en admin) avec :
```powershell
powershell -ep Bypass .\wsl-port-forwarding.ps1
```

## Modification ENV et RB pour accès depuis LAN
Pour pouvoir accéder au back via websockets depuis une machine externe sur le LAN il faut changer `localhost` en `192.168.1.18` (IP de la machine hôte) et ajouter cette IP dans les whitelists.

### `scripts/dev`
```shell
# lines 3-4
export REACT_APP_API_BASE_URL=http://192.168.1.18:3000/
export REACT_APP_ACTION_CABLE_URL=http://192.168.1.18:3000/cable
```

### `api/config/environments/development.rb`
```rb
# lines 83-87
  config.action_cable.allowed_request_origins = [
    'http://192.168.1.18:5200', # <<<<<< THIS
    'http://localhost:5200',
    'http://dev.phoenix-contact.kinoba.fr:5200',
    'https://dev.phoenix-contact.kinoba.fr:5200'
  ]
```

### `api/config/initializers/cors.rb`
```rb
# lines 3-22
front_origins = if ENV['SENTRY_ENV'] == 'Dev' || ENV['SENTRY_DSN'].blank?
                  [
                    'http://192.168.1.18:5200', # <<<<<< THIS
                    'http://localhost',
                    'http://localhost:5200',
                    'http://localhost:8282',
                    'http://nginx',
                    'http://dev.phoenix-contact.kinoba.fr:5200',
                    'https://dev.phoenix-contact.kinoba.fr:5200'
                  ]
                elsif ENV['SENTRY_ENV'] == 'Recette'
                  [
                    'http://recette.dev.phoenix-contact.kinoba.fr.fr',
                    'https://recette.dev.phoenix-contact.kinoba.fr.fr'
                  ]
                elsif ENV['SENTRY_ENV'] == 'Production'
                  [
                    'http://localhost:8080',
                    'http://149.208.73.73:8080'
                  ]
                end

```

## Lancer le serveur local
```shell
./scripts/dev
```
Accès au site via `http://192.168.1.18:5200` (IP machine hôte)