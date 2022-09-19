#!/bin/bash

find . -name '*erb' | \
xargs ruby -e 'ARGV.each { |i| puts "erb2slim #{i} #{i.sub(/erb$/,"slim")}"}'
# | \
# bash
