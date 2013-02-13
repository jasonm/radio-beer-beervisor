watch('^(?!tmp)(?!static/css-compiled).*$') do
  system("kanso push")
  system("touch tmp/livereload.txt")
end

puts "Watchr running."
