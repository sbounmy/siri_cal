says /^(?:|a )movie (.+)$/i do |movie_name|
  puts "[Siri] Movie #{movie_name} scheduled by #{@object.name} at #{@event.start_time}"
end