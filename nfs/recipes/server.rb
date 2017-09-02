yum_package 'nfs-utils' do
  action :install
end

directory (node['nfs']['server']['mount']).to_s do
  owner 'nfsnobody'
  group 'nfsnobody'
  mode '0777'
  action :create
end

template '/etc/exports' do
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

['rpcbind', 'nfs-server', 'nfs-lock', 'nfs-idmap'].each do |serv|
  service serv do
    action [:enable, :start]
  end
end
