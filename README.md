# README

## Server deployment (Digital Ocean) - Initial setup
### If you don't have your computers SSH key on Digital Ocean, it may be necessary to set it up and add it to Digital Ocean (DON'T DO THIS IF YOU STILL HAVE YOUR SSH KEY ADDED):
```
ssh-keygen -t rsa -C "your_github_email@example.com" #press enter multiple times for default
cat ~/.ssh/id_rsa.pub #copy-paste this onto Digital Ocean settings to give computer access to repo Droplet
```

Copy this newly generated SSH key and paste the newly generated key to Droplet (only if it has not already been added)

### Setup newly created Droplet (Ubuntu droplet with rails)
#### Step 1 (clone project to server)
```
ssh rails@<server-ip-here>
ssh-keygen -t rsa -C "your_github_email@example.com" #press enter multiple times for default
cat ~/.ssh/id_rsa.pub #copy-paste this onto Github settings to give server (Droplet) access to repo
#now that the Droplet has access to Github repository (assuming you aded the above key from the Droplet to Github), you can:
git clone git@github.com:CG-Guy/events_platform.git
cd events_platform
rvm install "ruby-2.7.0"
rvm list
rvm use ruby-2.7.0
bundle install
yarn install --check-files
nano .env.development # or later on .env.production, and make sure all the right environment variables are added (see below example which may be expanded later on)
rake db:setup
rails restart
logout
```

sample .env.development file:
```
EVENTS_PLATFORM_DATABASE_USERNAME=<upon login, Digital Ocean prints out DB username - add it in this file>
EVENTS_PLATFORM_DATABASE_PASSWORD=<upon login, Digital Ocean prints out DB password - add it in this file>
```

#### Step 2 (setup root related stuff)
```
ssh root@<server-ip-here>
apt-get update
apt install imagemagick
nano /etc/systemd/system/rails.service

```

While in nano mode in this file (puma configuration), make sure it looks like this (to point to the repo)

```
[Unit]
Description=ExampleApp
Requires=network.target

[Service]
Type=simple
User=rails
Group=rails
WorkingDirectory=/home/rails/events_platform/
ExecStart=/bin/bash -lc 'bundle exec puma'
TimeoutSec=30s
RestartSec=30s
Restart=always

[Install]
WantedBy=multi-user.target
```

After making changes to puma.service, restart service:
```
systemctl daemon-reload
or
systemctl restart rails
```

Now, make sure that Nginx is configured to this new repo, by changing the following file:

`nano /etc/nginx/sites-available/rails`

And change the file to look like the following (More info here for troubleshooting: https://github.com/puma/puma/blob/master/docs/systemd.md):

```
server {
    listen   80;
    root /home/rails/events_platform/public;
    server_name _;
    index index.htm index.html;

        location ~ /.well-known {
                allow all;
        }

        location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

After saving this, test changes, before restarting nginx:
```
nginx -t
```

If this passes, it is now safe to restart nginx, and other services:
```
/etc/init.d/nginx restart
logout

```

#### Step 3 (ssh as rails user again)

```
ssh rails@<ip here>
cd events_platform
rails restart
```

## Doing a normal deploy 
```
ssh rails@<ip here>
cd events_platform
git pull
bundle install
yarn install --check-files
rake db:setup
rails restart
logout
```

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


