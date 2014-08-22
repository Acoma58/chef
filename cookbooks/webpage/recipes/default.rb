#
# Cookbook Name:: webpage
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx" 

directory "/var/www" do
  owner "root"
  group "root"
  mode 00755
  action :create
end


directory "/var/www/nginx-default" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

cookbook_file "cookbook_test_file" do
  path "/var/www/nginx-default/index.html"
  mode 0644
  owner "root"
  group "root"
  source "index.html"
  action :create_if_missing
end




