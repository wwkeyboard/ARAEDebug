module ARD
  def self.new_logger
    @new_logger ||= build_new_logger
  end

  def self.build_new_logger
    returning Object.new do |obj|
      def obj.debug?
        true
      end

      def obj.debug(input)
        puts "--> #{input}"
      end
    end
  end

  def self.redirect(new_logger = nil, &block)
    if block_given?
      ActiveRecord::Base.connection.instance_eval <<-SRC
        @old_logger = @logger
        @logger = ARD.new_logger
      SRC
      yield
      ActiveRecord::Base.connection.instance_eval <<-SRC
        @logger = @old_logger
      SRC
    end
  end
end