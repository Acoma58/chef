log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/var/tmp/chef-repo/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '/var/tmp/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://54.187.240.209:443'
syntax_check_cache_path  '/var/tmp/chef-repo/.chef/syntax_check_cache'
cookbook_path [ './cookbooks','./site-cookbooks' ]

knife[:aws_access_key_id]      = ENV['AWS_ACCESS_KEY_ID']
knife[:aws_secret_access_key]  = ENV['AWS_SECRET_ACCESS_KEY']

# Default flavor of server (m1.small, c1.medium, etc).
# #knife[:flavor] = "m1.small"
#
# # Default AMI identifier, e.g. ami-12345678
# #knife[:image] = ""
#
# # AWS Region
knife[:region] = "us-west-2"
#
# # AWS Availability Zone. Must be in the same Region.
knife[:availability_zone] = "us-west-2b"
#
# # A file with EC2 User Data to provision the instance.
# #knife[:aws_user_data] = ""
#
# # AWS SSH Keypair.
knife[:aws_ssh_key_id] = "nimbus"

