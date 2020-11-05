module RN
  module Tool
      #TODO- Fix the char \ why not reject
      def name_check(title)
          if (title.match?(/[<>:;,?"*|\/.]+/)) 
              puts """
              Algun nombre ingresado es invalido! 
              No se puede ingresar los siguientes caracteres en el nombre de la nota:  <, >, *, :, ; , /,\,|"""
              return false
          end
          return true
      end 

      #TODO- Make these methods more generic. 
      #Try to send a block, allowing play with this conditional
      def book_exist(book)
          if !File.exist?( Paths.book_path(book))
              puts "--------------------------------------------------------------------\n No existe el book '#{book}'! \n--------------------------------------------------------------------"
              return false
          end 
          return true
      end

      def book_not_exist(book)
        if File.exist?(Paths.book_path(book))
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
