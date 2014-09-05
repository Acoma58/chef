#
# Cookbook Name:: re-boot
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "doit" do
  command <<-EOF
   aptitude update -y
   aptitude safe-upgrade -y
   init 6
  EOF
end

