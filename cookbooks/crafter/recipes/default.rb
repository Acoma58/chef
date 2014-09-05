#
# Cookbook Name:: crafter
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

swap_file '/opt/swap' do
  size      3582   # MBs
  persist  true
end

package "numactl" do
  action :install
end

mount "/opt" do
  device "/dev/xvdf1"
  fstype "ext4"
  options "rw"
  action [:mount, :enable]
end


