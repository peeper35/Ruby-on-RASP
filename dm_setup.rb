require 'sqlite3'


db = SQLite3::Database.new("logindata.db")

rows = db.execute <<-SQL
  create table logins (
    username varchar(30),
    password varchar(30)
  );
SQL

{
  "Sahil" => "Sahil",
  "admin" => "admin",
  "elliot" => "qwerty",
  "user1" => "ih8uall",
  "dinesh" => "iamnotindian",
  "rick" => "dubdub"   
}.each do |pair|
  db.execute "insert into logins values ( ?, ? )", pair
end

db.execute( "select * from logins") do |row|
  p row
end

puts "\nDatabase Created!"
