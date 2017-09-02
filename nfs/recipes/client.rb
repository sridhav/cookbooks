yum_package 'nfs-utils' do
  action :install
end

directory (node['nfs']['client']['mount']).to_s do
  owner 'root'
  group 'root'
  mode '0755'
  only_if { !::Dir.exist?((node['nfs']['client']['mount']).to_s) }
  action :create
end

mount (node['nfs']['client']['mount']).to_s do
  device "#{node['nfs']['client']['nfsserver']}:#{node['nfs']['client']['nfsmount']}"
  fstype 'nfs'
  action [:mount, :enable]
end
