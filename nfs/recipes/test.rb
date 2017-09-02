template '/tmp/mount-disk' do
  source 'test.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory (node['nfs']['test']['mount']).to_s do
  owner 'root'
  group 'root'
  mode '0755'
  only_if { !::Dir.exist?((node['nfs']['test']['mount']).to_s) }
  action :create
end

bash 'mount-disk' do
  code 'source /tmp/mount-disk'
  action :run
end

mount (node['nfs']['test']['mount']).to_s do
  device "#{node['nfs']['test']['device']}1"
  action :mount
end
