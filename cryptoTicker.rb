#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'open-uri'
require 'json'

#
# Colors
#
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end
end

#
# Build and Display Table
#
def display(limit)
apiURL = "https://api.coinmarketcap.com/v1/ticker"
system("clear")
print "Currency".center(30)
print "Price\t1 Hour\t24 Hour\t7 Days"
print "\n"
print "-" * 65
print "\n"
#
# Retrieve Data
#
buffer = open(apiURL).read
result = JSON.parse(buffer)

result.first(limit).each do |crypto|

    print "#{crypto['name']} (#{crypto['symbol']})".center(30)

    if crypto['percent_change_1h'].to_s[0] == "-"
        print "#{crypto['price_usd'].to_f.round(3)}\t".red
        print "#{crypto['percent_change_1h']}%\t".red
    else
        print "#{crypto['price_usd'].to_f.round(3)}\t".green
        print "#{crypto['percent_change_1h']}%\t".green
    end

    if crypto['percent_change_24h'].to_s[0] == "-"
        print "#{crypto['percent_change_24h']}%\t".red
    else
        print "#{crypto['percent_change_24h']}%\t".green
    end

    if crypto['percent_change_7d'].to_s[0] == "-"
        print "#{crypto['percent_change_7d']}%\t".red
    else
        print "#{crypto['percent_change_7d']}%\t".green
    end
    print "\n"
end
end

# Run in a loop
while 1==1
    display(10)
    sleep 300
end
