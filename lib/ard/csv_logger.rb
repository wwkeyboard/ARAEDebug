module ARD
  class CsvLogger
    LOG_FILE = File.join(RAILS_ROOT, 'log', 'queries.csv')
    def initialize
      @@log_file = File.open(LOG_FILE, "w")
      @@start_time = Time.now.to_f
    end

    def debug?
      true
    end

    def debug(input)
      @@log_file.write "#{running_time},#{input}\n"
    end

    private

    def running_time
      Time.now.to_f - @@start_time
    end
  end
end