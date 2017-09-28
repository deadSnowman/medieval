# This program mimics the functionality of the tf2 chat parser
# used in DeGroot Keep.  The input turns into something similar to
# "Ye Old English" by following rules set in a provided json file
# This could potentially be used for pirate speak or something
# in the future.
#
# Author::  Seth A. Thomas
# Copyright:: Copyright (c) 2017 Seth A. Thomas
# License::   MIT License

#!/usr/bin/env ruby
require 'json'


# The Medieval chat parser class
# Takes a json document and uses it for the translation
class Medieval
  #constr
  def initialize(data)
    @data = data
  end

  # Returns json parsed file
  def printData()
    puts @data
  end

  # Translates to tf2's Ye Old English like language
  # Params:
  # +input+:: text input to be translated
  def translate(input)
    outStr = input.downcase

    # prepended
    outStr = prep(outStr)
    
    # replace words
    # still need to add punctuation and more of the words in general
    outStr = singleWords(outStr)

    # insults (replace)
    outStr = insults(outStr) #get this working too

    # appended
    outStr = appnd(outStr)

    puts outStr
  end

  def insults (inp)
    outStr = ""
    # haven't done this part yet
    return inp.gsub("\n", " ")
  end

  def singleWords(inp)
    transl = inp

    @data["single_replacements"].each do |key, array|
      if array.length == 1
        transl = transl.gsub(/\b#{key}\b/, array[0])
      else
        transl = transl.gsub(/\b#{key}\b/, array[Random.rand(array.length)])
      end
    end

    return transl
  end

  def appnd(inp)
    randAppnd = ""
    appnd = @data["appended_words"]
    randAppnd << appnd[Random.rand(appnd.length)]
    return inp.gsub("\n", " ") + randAppnd
  end

  def prep(inp)
    randPrep = ""
    prep = @data["prepended_words"]
    randPrep << prep[Random.rand(prep.length)]
    return randPrep + inp
  end

end


# Initialize stuff
json = ""
file = "./dict.json"

# Read file and parse
if File.exists?(file)
  File.open(file, "r") do |f|
    json = f.read
  end
end
data = JSON.parse(json)

# Instantiate
med = Medieval.new(data)

# Get user input
puts "Enter text: "
input = gets
puts ""

# Translate
med.translate(input)



