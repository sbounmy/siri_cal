SiriCal
=======

SiriCal is a simple limited solution to handle [iOS 5 Siri feature][s] in your Ruby app :

* provides Siri helpers to your ruby app by synchronizing google calendar events.
* an alternative limited solution before Apple release an API for Siri.
* relies on google_calendar gem : [google_calendar][gc].

This gem is much inspired by Tyson Tale's hack: [siri_says][ss].

Installation
------------

#### Rails app

You can use the latest Rails 3 gem with the latest SiriCal gem:

In your gemfile
      
    gem 'siri_cal'

or using rubygems

    gem install siri_cal

After you install SiriCal, you need to run the generator:

    rails generate siri_cal:install

The generator will install:

* an initializer which describes most SiriCal’s configuration options.
* a step file which describe siri sayings

#### iPhone

Add the calendar:

1. Settings
2. "Mail, Contacts, Calendars"
3. "Add Account..."
4. "Other"
5. "Add CalDAV Account"
    * Server: google.com
    * Username: username@gmail.com
    * Password: ___________
    * Description: "sirical"
6. "Next"

Choose the calendar as default so Siri will add events to it:

1.  Settings
1.  "Mail, Contacts, Calendars"
2.  "Default Calendar" --> sirical

Usage
-----

A model

    class User < ActiveRecord::Base
      siriable
      has_many  :movies
    end
    

Be sure to have 2 fields containing your google calendar

* login (siriable_login here)
* password (siriable_password here)

db/schema.rb should look like:

    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "siriable_login"
      t.string   "siriable_password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

In lib/siri_says/default.rb

    says /a movie (.+)/i do |movie_name|
      puts "[Siri] Movie '#{movie_name}' scheduled by #{@object.name} at #{@event.start_time}"
    end

* @object is the User instance "bob"
* @event is the Google::Event instance

Tell Siri:
    
    "Schedule a movie transformers right now."

In your ruby code:

    user = User.create :name => "bob", :siriable_login => "bob@gmail.com", :siriable_password => "bobibob"
    user.execute_siri!

(seconds later)

    [Siri] Movie 'transformers' scheduled by bob at 2010-11-08 12:20

Example of events
------------------

From [Siri Says][ss] :

#### Immediate events

To create an immediate event, you can either create an event "now" or "all-day tomorrow":

* "Schedule a movie right now"
* "Schedule an event right now: movie"
* "Schedule an appointment tomorrow, all-day: movie"
* "New appointment now: movie"
* Etc.

#### Scheduled events

Create events that fire later just like you would any other scheduled event:

* "New appointment for tomorrow at 4am: deploy"
* "Schedule a deploy tomorrow at 4am"
* "Schedule an event tomorrow at 4am: deploy"
* "Schedule an appointment tomorrow, at 4am: deploy"
* Etc.

Compatibility
-------------

Tested under Rails 3.X.

Contribute
----------

Pull requests for features and bug fix with tests are welcome.

This is my first gem so please consider this as beta version.

TODO
----

* Find an asynchronous way to get calendar events.
* Possibility to use different caldav servers, not only gmail.

License
-------

This project rocks and uses MIT-LICENSE.

[s]: http://www.apple.com/iphone/features/siri.html
[ss]: https://github.com/tysontate/siri_says
[gc]: https://github.com/northworld/google_calendar