module ARD
  def self.logger
    @logger ||= ARD::BasicLogger.new
  end

  def self.redirect(new_logger = nil, &block)
    @logger = new_logger if new_logger
    if block_given?
      ActiveRecord::Base.connection.instance_eval <<-SRC
        @old_logger = @logger
        @logger = ARD.logger
      SRC
      ret = yield
      ActiveRecord::Base.connection.instance_eval <<-SRC
        @logger = @old_logger
      SRC
      ret
    end
  end
end