# install openssl-devel and sqlite-devel
%w{openssl-devel sqlite-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

# rbenv
git "/home/#{node['ruby-env']['user']}/.rbenv" do
  repository node['ruby-env']['rbenv_url']
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

template ".bash_profile" do
  source ".bash_profile.erb"
  path   "/home/#{node['ruby-env']['user']}/.bash_profile"
  mode   0655
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
  not_if "grep rbenv ~/.bash_profile", environment: { :'HOME' => "/home/#{node['ruby-env']['user']}" }
end

# ruby
directory "/home/#{node['ruby-env']['user']}/.rbenv/plugins" do
  mode   0755
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
  action :create
end

git "/home/#{node['ruby-env']['user']}/.rbenv/plugins/ruby-build" do
  repository node['ruby-env']['ruby-build_url']
  action :sync
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
end

# install ruby
execute "rbenv install #{node['ruby-env']['version']}" do
  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv install #{node['ruby-env']['version']}"
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
  environment 'HOME' => "/home/#{node['ruby-env']['user']}"
  not_if { File.exists?("/home/#{node['ruby-env']['user']}/.rbenv/versions/#{node['ruby-env']['version']}") }
end

# set rbenv global
execute "rbenv global #{node['ruby-env']['version']}" do
  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv global #{node['ruby-env']['version']}"
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
  environment 'HOME' => "/home/#{node['ruby-env']['user']}"
end

# install rbenv-rehash and bundler gem
%w{rbenv-rehash bundler}.each do |gem_name|
  execute "gem install #{gem_name}" do
    command "/home/#{node['ruby-env']['user']}/.rbenv/shims/gem install #{gem_name}"
    user   node['ruby-env']['user']
    group  node['ruby-env']['group']
    environment 'HOME' => "/home/#{node['ruby-env']['user']}"
    not_if "/home/#{node['ruby-env']['user']}/.rbenv/shims/gem list | grep #{gem_name}"
  end
end
