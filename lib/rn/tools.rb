module Tool
    #TODO- Fix the char \ why not reject
    def name_check(title)
        if (title.match?(/[<>:;,?"*|\/\/.]+/)) 
            puts """
            El nombre de la nota es invalido! 
            No se puede ingresar los siguientes caracteres en el nombre de la nota:  <, >, *, :, ; , /,\,|"""
            abort
        end
    end 

    def book_exist(book)
        if !File.exist?("./app/#{book}")
            puts "--------------------------------------------------------------------\n No existe el book '#{book}'! \n--------------------------------------------------------------------"
            abort            
        
        end 
    end

    #Maybe these methods be return a true or false.

    def note_exist(name,book)
          if File.exist?("./app/#{book}/#{name}.rn")
            puts "--------------------------------------------------------------------\n La nota con el titulo '#{name}' ya existe! \n--------------------------------------------------------------------"
            abort
          end
             
    end

    def note_not_exist(name,book)

      if !File.exist?("./app/#{book}/#{name}.rn")
        puts "--------------------------------------------------------------------\n La nota con el titulo '#{name}' no existe! \n--------------------------------------------------------------------"
        abort
      end
         
end



end