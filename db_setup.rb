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



rows = db.execute <<-SQL
  create table sqli_rules (
    sqlirule varchar(1000)
  );
SQL

sqli = "[[STRING], [WHITESPACE], [OPERATOR], [WHITESPACE], [STRING], [WHITESPACE], [STRING], [WHITESPACE], [STRING], [WHITESPACE], [STRING], [WHITESPACE], [EQUALS], [SINGLEQ], [STRING], [SINGLEQ], [WHITESPACE], [STRING], [WHITESPACE], [STRING], [WHITESPACE], [EQUALS], [SINGLEQ], [STRING], [SINGLEQ]]"

db.execute "insert into sqli_rules ( sqlirule ) values ( ? )", [sqli]

db.execute("select * from sqli_rules") do |row|
  p row
end

puts "\nSQLi Rule Added!"
