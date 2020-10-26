module Tool
    
    #def find_note (title,book, msg)
    #    begin
    #      
    #      if !File.exist?("./app/#{book}/#{title}.rn")
    #        puts "--------------------------------------------------------------------\n #{msg} \n--------------------------------------------------------------------"
    #        abort
    #      else 
    #        return true
    #      end
    #        
    #    end
    #  end 
    def book_exist(book)
        if !File.exist?("./app/#{book}")
            puts "--------------------------------------------------------------------\n No existe el book '#{book}'! \n--------------------------------------------------------------------"
            abort            
        
        end 
    end

    #TODO Fixear la \ que no la rechaza
    def name_check(title)
        if (title.match?(/[<>:;,?"*|\/\/.]+/)) 
          puts """
          El nombre de la nota es invalido! 
          No se puede ingresar los siguientes caracteres en el nombre de la nota:  <, >, *, :, ; , /,\,|"""
          abort
        end
    end

end