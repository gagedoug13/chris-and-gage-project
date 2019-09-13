require_relative 'config/environment.rb'
require 'sinatra/activerecord/rake'
require 'csv'

desc "parse csv"

task :csv do 
    db = SQLite3::Database.new("db/Halloween_hallows.db")
    db.execute("CREATE TABLE IF NOT EXISTS events (
      id INTEGER PRIMARY KEY,
      title,
      event_type,
      day,
      description,
      time_of_day,
      location
    )")
  
    csv_text = File.read("events.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      db.execute("INSERT INTO events (
        title,
        event_type,
        day,
        description,
        time_of_day,
        location
        ) VALUES(?,?,?,?,?,?)",
        row["title"], row["event_type"], row["day"], row["description"], row["time_of_day"], row["location"]
        )
    end
  end 