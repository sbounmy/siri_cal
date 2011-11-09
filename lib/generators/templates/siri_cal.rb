SiriCal.setup do |config|
  # Configure the path containing the siri says files.
  config.siri_says_path = "lib/siri_says"

  # Set the delete event policy
  # :success  delete event only when event matches one of the siri says block
  # :always   delete event once it is fetched from calendar
  # :none     never delete event
  config.delete_event = :success

  # Set the calendar name to connect to. Default: "sirical"
  # config.calendar_name = "sirical"
end