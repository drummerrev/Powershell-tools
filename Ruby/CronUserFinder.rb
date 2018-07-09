#!/usr/bin/ruby

h = Hash.new(0)

File.open("/var/log/system.log").each do |line|
    if line.include?("cron")
        m = /\((.+)\)$/.match(line)
        username = m[1]
        usernames[username] += 1
    end
end

puts m.captures



