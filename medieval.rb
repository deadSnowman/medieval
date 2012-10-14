#!/usr/bin/env ruby
require 'json'

json = ""
file = "./dict.json"
displayString = ""
flag = false

if File.exists?(file)
  File.open(file, "r") do |f|
    json = f.read
  end
end

data = JSON.parse(json)
# Display all data
#data.each do |key, value|
#  puts "#{key}: #{value}"
#end

# GET USER INPUT
puts "Enter text: "
input = gets
input = input.split(' ')
puts ""

entries = data["dict"]["prepended_words"]["entries"].to_i


# PREPENDED WORDS
displayString = displayString + data["dict"]["prepended_words"][Random.rand(entries).to_s]




# WORD REPLACEMENTS
input.each_with_index do |val, i|
  # if there is a replacement, continue
  if data["dict"]["word_replacements"][val.to_s]

    # if the word is a possible contraction, check
    if data["dict"]["word_replacements"][val.to_s]["type"] == "contraction"
      # if it is, check what to replace
      data["dict"]["word_replacements"][val.to_s].each_pair do |j, k|
        if j != "type" # ignore type
          if j == input.to_a[i+1]
            # replace
            displayString = displayString + k + " "
            flag = true
            break
          end    
        end
      end
      # display if 1st word isn't part of a contraction
      if !flag
        displayString = displayString + val.to_s + " "
        flag = false
      end

    else 
      # replace word
      displayString = displayString + data["dict"]["word_replacements"][val.to_s][Random.rand(entries).to_s].chomp + " "
    end

    # display if second word isn't part of a contraction
  else
    if flag != true
      displayString = displayString + val.to_s + " "
    end
    flag = false
  end
end





# APPENDED WORDS
displayString = displayString + data["dict"]["appended_words"][Random.rand(data["dict"]["appended_words"]["entries"].to_i).to_s]

# DISPLAY
puts displayString








=begin
Enter text: 
test

./medieval.rb:28:in `+': can't convert nil into String (TypeError)
  from ./medieval.rb:28:in `<main>'


-------------------

Enter text: 
it is god good sir

./medieval.rb:28:in `+': can't convert nil into String (TypeError)
  from ./medieval.rb:28:in `<main>'
  seth@debian:~/Programming/Ruby/medieval$ ./medieval.rb 
  Enter text: 
  it is good god sir

  Heigh-ho, 'tis good Loki sir Guvnor!



=end
