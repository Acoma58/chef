#
# Cookbook Name:: webpage
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx" 

package "libplack-perl" do
  action :install
end

directory "/var/www" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

file "/var/www/app.psgi" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

cookbook_file "cookbook_test_file" do
  path "/etc/init.d/webpage"
  mode 0755
  owner "root"
  group "root"
  source "webpage"
  action :create
end

cookbook_file "nginx_config_file" do
  path "/etc/nginx/sites-enabled/default"
  mode 0644
  owner "root"
  group "root"
  source "nginx_default"
  action :create
end

cookbook_file "doit_executable" do
  path "/usr/bin/doit"
  mode 0755
  owner "root"
  group "root"
  source "doit"
  action :create
end

cookbook_file "psgi" do
  path "/var/www/app.psgi"
  mode 0755
  owner "root"
  group "root"
  source "app.psgi"
  action :create
end

service "webpage" do
  action [ :start, :enable ]
end

service "nginx" do
  action :restart 
end
