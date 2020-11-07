module RN

    module Output
        def not_exist(msg)
            puts "#{msg} no existe!"
        end

        def exist(msg)
            puts "#{msg} ya existe!"
        end

        def success(msg)
            puts "#{msg} con exito!"
        end

        def show(element)
            puts "--------------------------------------------------------------------\n"
            puts element
            puts "--------------------------------------------------------------------\n"
        end

        def name_check_error()
            puts """
              Algun nombre ingresado es invalido! 
              No se puede ingresar los siguientes caracteres en el nombre de la nota:  <, >, *, :, ; , /,\,|"""
        end
    end
end