require 'test_helper'

class SiriCalTest < ActiveSupport::TestCase
  fixtures :users

  should "responds to SiriCal instance methods" do
    assert User.last.respond_to?(:execute_siri!)
  end

  context '#calendar' do
    should "raises an error with invalid credentials" do
      VCR.use_cassette("invalid_credentials") do
        assert_raise(Google::HTTPAuthorizationFailed) { User.last.calendar }
      end
    end

    should 'returns an instance of Google::Calendar on valid credentials' do
      VCR.use_cassette("valid_credentials") do
        assert_nothing_raised do
          assert_kind_of Google::Calendar, User.last.calendar
        end
      end
    end
  end

  context '#execute_siri!' do
    setup do
      @user = User.last
    end

    should 'fetch cal events and match their title to defined step in siri_says/default.rb' do
      SiriCal.setup { |config| config.delete_event = :none }
      VCR.use_cassette("valid_credentials_with_events") do
        assert_difference('@user.movies.count', 1, 'a movie should be created') { @user.execute_siri! }
        assert_equal "transformers", @user.movies.last.name
        assert_not_nil @user.calendar.events
      end
    end

    should 'delete event when config.delete is :success' do
      SiriCal.setup { |config| config.delete_event = :success }
      VCR.use_cassette("valid_credentials_with_events_to_delete") do
        assert_difference('@user.movies.count', 1, 'a movie should be created') { @user.execute_siri! }
        assert_equal "transformers", @user.movies.last.name
        assert_nil @user.calendar.events
      end
    end

    should 'delete event when config.delete is :always' do
      SiriCal.setup { |config| config.delete_event = :always }
      VCR.use_cassette("valid_credentials_with_events_to_delete") do
        assert_difference('@user.movies.count', 1, 'a movie should be created') { @user.execute_siri! }
        assert_equal "transformers", @user.movies.last.name
        assert_nil @user.calendar.events
      end
    end
  end

  context "#invoke_say" do
    setup do
      @event = Google::Event.new(:title => "I have a foo", :start_time => Time.now)
    end

    should "handle @object in says block" do
      says /I have a foo/ do
        User.find_by_name(@object.name)
      end
      assert_nothing_thrown { SiriCal::SayProxy.invoke_say(@event, User.last) }
    end

    should "handle @event in says block" do
      says /I have a foo/ do
        @event.start_time
      end
      assert_nothing_thrown { SiriCal::SayProxy.invoke_say(@event, User.last) }
    end

    teardown do
      SiriCal::SayProxy.clear
    end
  end
end
