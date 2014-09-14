#
# Cookbook Name:: dashboard
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

for pkg in  [ "git", "python-pip", "python-dev", "nginx", "s3cmd", "gdal-bin",
    "r-base", "python-gdal", "libpq-dev", "postgresql-9.3-postgis-2.1",
    "libcurl4-openssl-dev", "libxml2-dev" ] do
  package pkg do
    action :install 
 end
end

##============================================================

remote_file "#{Chef::Config[:file_cache_path]}/Rserve_1.8-0.tar.gz" do 
  source "https://s3.amazonaws.com/fbndeploy/Rserve_1.8-0.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/mgcv_1.8-0.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/mgcv_1.8-0.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/e1071_1.6-3.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/e1071_1.6-3.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/randomForest_4.6-7.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/randomForest_4.6-7.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/XML_3.98-1.1.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/XML_3.98-1.1.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/sp_1.0-15.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/sp_1.0-15.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/bitops_1.0-6.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/bitops_1.0-6.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/geosphere_1.3-8.tar.gz" do
 source "https://s3.amazonaws.com/fbndeploy/geosphere_1.3-8.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/maptools_0.8-30.tar.gz" do
  source "https://s3.amazonaws.com/fbndeploy/maptools_0.8-30.tar.gz"
end

remote_file "#{Chef::Config[:file_cache_path]}/get-pip.py" do
  source "https://bootstrap.pypa.io/get-pip.py"
end

##============================================================

for blob in ["Rserve_1.8-0.tar.gz", "mgcv_1.8-0.tar.gz", "e1071_1.6-3.tar.gz",
       "randomForest_4.6-7.tar.gz", "XML_3.98-1.1.tar.gz", "sp_1.0-15.tar.gz", 
 "bitops_1.0-6.tar.gz", "geosphere_1.3-8.tar.gz","maptools_0.8-30.tar.gz" ] do

  execute "install_blobs" do
  not_if do ::File.exists?("#{Chef::Config[:file_cache_path]}/." + blob) end
  cwd #{Chef::Config[:file_cache_path]} 
  command "R CMD INSTALL " + "#{Chef::Config[:file_cache_path]}" + "/" + blob + " && touch #{Chef::Config[:file_cache_path]}/." + blob
  end
end

service "postgresql" do
 supports :status => true, :restart => true, :reload => true
 action [:enable, :start]
end

for pcommand in [ 'createuser ubuntu', 'createdb -U ubuntu ubuntu', "echo 'GRANT ALL PRIVILEGES ON ubuntu TO ubuntu;' | psql", "echo 'ALTER ROLE ubuntu WITH SUPERUSER;' | psql", "touch $HOME/.done"] do
execute "do_postgres_stuff" do
   not_if do ::File.exists?("/var/lib/postgresql/.done") end
   cwd "/var/lib/postgresql"
   user "postgres"
   action :run
   environment ({'HOME' => '/var/lib/postgresql', 'USER' => 'postgres'})
   command pcommand
 end
end
