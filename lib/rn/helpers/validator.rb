module RN
  module Helpers
    module Validator

        def name_check?(title)
          return title.match?(/^[A-Za-z0-9\s]+$/)
        end 
            
    end
  end
end
