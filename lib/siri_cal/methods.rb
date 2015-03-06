require 'google_calendar'

module SiriCal
  module ClassMethods
    # Public: Initialize a Siriable object.
    #
    # options - The Hash options used to redefine the config (default: {}):
    #           :login  - The Symbol login field to sign in with (default: :login).
    #           :password - The Symbol login field to sign in with (default: :password).
    #
    # Examples
    #
    #   siriable :login => :caldav_login, :password => :caldav_password
    #
    #
    # Returns nothing.

    def siriable options={}
      config = {}
      config[:login] = options.delete(:login) || :siriable_login
      config[:password] = options.delete(:password) || :siriable_password
      config.each do |key, value|
        define_method "siri_cal_#{key}" do
          self.send(value)
        end
      end
    end
  end

  module InstanceMethods
    # Public: Initialize calendar
    #
    # Returns an instance of Google::Calendar.
    def calendar
      Google::Calendar.new :username => siri_cal_login, :password => siri_cal_password, :calendar => calendar_name
    end

    # Public: GET calendar's event and run then according to block defined in lib/siri_says.rb
    #
    # Returns nothing.
    def execute_siri!(background=false)
      background ? Delayed::Job.enqueue(SiriJob.new(self.id, self.class)) : load_siri
    end

    def load_siri
      SayProxy.load_files
      calendar.events.to_a.each do |event|
        res = SayProxy.invoke_say(event, self)
        event.delete if (res && delete_event == :success) || delete_event == :always
      end
    end
  end
end