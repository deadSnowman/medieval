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

#ignore case
input.each_with_index do |n, m|
  input.to_a[m] = n.downcase
end

puts ""

entries = data["dict"]["prepended_words"]["entries"].to_i


# PREPENDED WORDS
displayString << data["dict"]["prepended_words"][Random.rand(entries).to_s]




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
            displayString << k + " "
            flag = true
            break
          end    
        end
      end
      # display if 1st word isn't part of a contraction
      if !flag
        displayString << val.to_s + " "
        flag = false
      end

    else 
      # replace word
      displayString << data["dict"]["word_replacements"][val.to_s][Random.rand(entries).to_s].chomp + " "
    end

    # display if second word isn't part of a contraction
  else
    if flag != true
      displayString << val.to_s + " "
    end
    flag = false
  end
end





# APPENDED WORDS
displayString << data["dict"]["appended_words"][Random.rand(data["dict"]["appended_words"]["entries"].to_i).to_s]

# DISPLAY
puts displayString
