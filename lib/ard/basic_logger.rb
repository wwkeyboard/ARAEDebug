module ARD
  class BasicLogger
    def debug?
      true
    end

    def debug(input)
      puts "#{input}"
    end
  end
end