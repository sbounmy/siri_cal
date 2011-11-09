says /^(?:|a )movie (.+)$/ do |movie_name|
  User.find_by_name(@object.name).movies.create! :name => movie_name, :scheduled_at => @event.start_time
end