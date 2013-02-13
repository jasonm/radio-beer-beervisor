watch('^(?!tmp)(?!static/css-compiled).*$') do
  system("kanso push && touch tmp/livereload.txt")
end

puts "Watchr running."
