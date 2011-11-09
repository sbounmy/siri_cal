module SiriCal

  class Say
    def initialize(regexp, &block)
      self.regexp, self.block = regexp, block
    end

    attr_accessor :regexp, :block, :captures
  end

  class SayProxy
    class << self
      def proxy
        @proxy ||= []
      end

      def <<(say)
        proxy << say
      end

      def count
        proxy.count
      end

      def matches_says(name)
        proxy.select { |say| !!(say.regexp =~ name and say.captures = $~.captures) }
      end

      def invoke_say(event, object=nil)
        matches = matches_says(event.title)
        raise RedundantError, "You should have only one say step that matches \"#{name}\"" if matches.size > 1
        if !matches.empty?
          m = matches.first
          @object, @event = object, event
          self.instance_exec(*m.captures, &m.block)
          return true
        end
        false
      end

      def clear
        proxy.clear
      end

      # Internal : Load only once Siri says files
      #
      # Returns true on success
      # Returns false if already loaded
      def load_files
        return false unless proxy.empty?
        Dir.glob(File.join(SiriCal.siri_says_path, "*")).each do |filename|
          load File.expand_path(filename)
        end
        true
      end

      def all
        proxy
      end
    end

  end
end