# chef

## environments

* local-development - for local development environment (centos 6.4 rbenv, nginx, nodejs, postgresql)
* staging - wip

## install process

```
# clone chef
git clone git@github.com:nipe0324/chef.git
cd chef

# create virtual machine with centos 6.4
vagrant up

# add vm ssh config to ~/.ssh/config
touch ~/.ssh/confg
vagrant ssh-config --host local-development >> ~/.ssh/config

# download community cookbooks
bundle exec berks vendor cookbooks

# install chef-solo to vm
bundle exec knife solo prepare local-development

# provision vm
bundle exec knife solo cook local-development
```

And, sample rails app with unicorn

```
cp -rp samples/sample_rails synced_folder/.
vagrant ssh
> cd synced_folder
> bundle install
> bundle exec rake db:migrate
> bundle exec unicorn -c config/unicorn.rb
```

Access `http://192.168.33.10/unicorn`. and see rails page.

## when change Berksfile

```
# download community cookbooks
bundle exec berks vendor cookbooks

# provision vm
bundle exec knife solo cook local-development
```

## when edit site-cookbooks

```
# provision vm
bundle exec knife solo cook local-development
```
