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
    #outStr = input.downcase
    outStr = input

    # replace words
    # still need to add punctuation and missing words
    outStr = single_words(outStr)

    # prepend and append
    outStr = prepend_and_append(outStr)

    # punctuation
    #outStr = punctuation(outStr)

    # change tags like &god or &bodypart, etc
    outStr = change_tags(outStr)


    puts outStr
  end

  def single_words(inp)
    transl = inp

    @data["single_replacements"].each do |key, array|
      transl = transl.gsub(/\b#{key}\b/i, array[Random.rand(array.length)])
    end

    return transl
  end

  def prepend_and_append(inp)
    randAppnd = ""
    randPrep = ""
    appnd = @data["appended_words"]
    prep = @data["prepended_words"]
    randAppnd << appnd[Random.rand(appnd.length)]
    randPrep << prep[Random.rand(prep.length)]
    return randPrep.gsub("\n", " ") + inp.gsub("\n", " ") + randAppnd
  end

  def punctuation(inp)
    transl = inp

    #@data["punctuation"].each do |key, array|
    #  transl = transl.gsub(/\b#{key}/, array[Random.rand(array.length)])
    #end

    return transl
  end

  def change_tags(inp)
    transl = inp
    @data["change_tags"].each do |key, array|
      transl = transl.gsub(key, array[Random.rand(array.length)])
    end

    return transl
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



