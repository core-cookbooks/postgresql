

bash "postgres-config" do
user 'postgres'
code <<-EOH
echo "psql template1" 
echo "update pg_database set datallowconn = TRUE where datname = 'template0';" | psql
echo "\c template0" | psql
echo "update pg_database set datistemplate = FALSE where datname = 'template1';" | psql
echo "drop database template1;" | psql
echo "create database template1 with template = template0 encoding = 'UTF8';" | psql
echo "update pg_database set datistemplate = TRUE where datname = 'template1';" | psql
echo "\c template1" | psql
echo "update pg_database set datallowconn = FALSE where datname = 'template0';" | psql
echo "ALTER ROLE postgres WITH PASSWORD '#{node['postgresql']['postgres_role_pwd']}';" | psql
echo "CREATE USER tad LOGIN PASSWORD  '#{node['postgresql']['tad_role_pwd']}';"  | psql
echo "ALTER USER tad WITH SUPERUSER CREATEROLE CREATEDB;"  | psql
echo "CREATE DATABASE openbravo WITH ENCODING='UTF8' OWNER=tad;" | psql
echo "Template1=#" | psql
echo "\q" | psql
EOH
action :run
end



ruby_block  "postgresqlconfig" do
block do
file_name = "/etc/postgresql/9.3/main/postgresql.conf"
replace_sentence = "listen_addresses = '*'"

File.open(file_name){ |source_file|
  contents = source_file.read
  contents.gsub!("listen_addresses = 'localhost'", replace_sentence)
  File.open(file_name, "w+") { |f| f.write(contents) }
} 
end
end


ruby_block "Bind address for postgresql" do
  block do
open('/etc/postgresql/9.3/main/pg_hba.conf', 'a') { |f|
  f << "host    all             all             0.0.0.0/0            md5"
}
  end
end

execute "Restart postgresql server" do
  user "root"
  command <<-EOF
       service postgresql restart
  EOF
end


#service "postgresql" do
#  service_name node['postgresql']['server']['service_name']
#  supports :restart => true, :status => true, :reload => true
#  action [:enable, :start]
#end