module ARD
  class JsonLogger
    LOG_FILE = File.join(RAILS_ROOT, 'public', 'sql_logs', "queries_#{Time.now.to_i}.json")
    def initialize
      @log_file = File.open(LOG_FILE, "w")
      @log_file.write "{ 'queries':[\n"
      
      @start_time = Time.now.to_f
      @comma = false
      
      at_exit { @log_file.write "]}\n" }      
    end

    def debug?
      true
    end

    def debug(input)
      log = ""
      @comma ? log << ",\n" : @comma = true
      log << "{'start_time':#{running_time},'query':'#{input.strip}'}"
      @log_file.write log
    end

    private

    def running_time
      Time.now.to_f - @start_time
    end
  end
end