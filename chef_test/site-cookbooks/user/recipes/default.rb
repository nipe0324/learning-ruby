group node["user"] do
  group_name node["user"]
  action     [:create]
end

user node["user"] do
  comment  "#{node["user"]} user"
  group    node["user"]
  home     "/home/#{node["user"]}"
  supports :manage_home => true
  action   [:create, :manage]
end

execute "chmod 755 /home/#{node['user']}/.bashrc" do
  user   node['ruby-env']['user']
  group  node['ruby-env']['group']
end
