Bundler.require
require 'active_support/concern'
require 'active_support/dependencies'
require 'rails/generators'

require 'generators/install'
require 'siri_cal/say_proxy'
require 'siri_cal/methods'
require 'delayed_job'
require 'siri_cal/siri_job'
module SiriCal
  extend ActiveSupport::Concern
  class RedundantError < StandardError; end;

  # Public: String path of the siri's says files. Default: "lib/siri_says"
  mattr_accessor :siri_says_path
  @@siri_says_path = "lib/siri_says"

  # Public: String path of the siri's says files. Default: :success
  mattr_accessor :delete_event
  @@delete_event = :success

  # Public: String name of the caldav calendar to connect to. Default: "sirical"
  mattr_accessor :calendar_name
  @@calendar_name = "sirical"

  def self.setup
    yield self
  end

  module StepMethods
    def says(regexp=nil, &block)
      @proxy = SayProxy
      @proxy << Say.new(regexp, &block) if regexp && block
      @proxy
    end
  end

end

ActiveRecord::Base.send :include, SiriCal
Object.send :include, SiriCal::StepMethods
