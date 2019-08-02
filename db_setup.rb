require 'sqlite3'
require 'colorize'


db = SQLite3::Database.new("logindata.db")

rows = db.execute <<-SQL
  create table logins (
    username varchar(30),
    password varchar(30)
  );
SQL

{
  "sahil" => "sahil",
  "admin" => "admin",
  "user1" => "ih8uall",
  "rick" => "dubdub"   
}.each do |pair|
  db.execute "insert into logins values ( ?, ? )", pair
end

db.execute("select * from logins") do |row|
  p row
end

puts "\nDatabase Created!\n".colorize(:green)


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

puts "\nSQLi Rule Added!\n".colorize(:green)


rows = db.execute <<-SQL
  create table rce_rules (
    rcerules varchar(1000)
  );
SQL

rce1 = "[[IP]]"
rce2 = "[[STRING], [STOP], [STRING]]"
rce3 = "[[STRING], [STOP], [STRING], [STOP], [STRING]]"
rce4 = "[[STRING]]"

db.execute "insert into rce_rules ( rcerules ) values ( ? )", [rce1]
db.execute "insert into rce_rules ( rcerules ) values ( ? )", [rce2]
db.execute "insert into rce_rules ( rcerules ) values ( ? )", [rce3]
db.execute "insert into rce_rules ( rcerules ) values ( ? )", [rce4]

db.execute("select * from rce_rules") do |row|
  p row
end

puts "\nRCE Rules Added!\n".colorize(:green)
