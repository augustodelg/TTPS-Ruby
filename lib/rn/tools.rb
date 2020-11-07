module RN
  module Tool
      #TODO- Fix the char \ why not reject
      def name_check(title)
        puts "aca"
          if title.match?(/[\/<>:;,?"*.|]+/)
            
            return false
          end
          return true
          
      end 

      #TODO- Make these methods more generic. 
      #Try to send a block, allowing play with this conditional
      def book_exist?(rute,tell_me)
          if File.exist?(rute) && Dir.file?(rute)
              return tell_me
          end 
          return !tell_me
      end

      def book_not_exist(rute)
        if File.exist?(rute )
            puts "--------------------------------------------------------------------\n Ya existe el book '#{book}'! \n--------------------------------------------------------------------"
            return false
        end 
        return true
      end

      def note_exist(name,book)
            if File.exist?(Paths.note_path(name,book))
              puts "--------------------------------------------------------------------\n La nota con el titulo '#{name}' ya existe! \n--------------------------------------------------------------------"
              return false
            end
            return true
              
      end

      def note_not_exist(name,book)

        if !File.exist?(Paths.note_path(name,book))
          puts "--------------------------------------------------------------------\n La nota con el titulo '#{name}' no existe! \n--------------------------------------------------------------------"
          return false
        end
        return true
      end
          
  end
end
