
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
