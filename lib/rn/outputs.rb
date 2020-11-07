module RN

    module Output

        def show_info(element)
            puts "--------------------------------------------------------------------\n"
            puts element
            puts "--------------------------------------------------------------------\n"
        end
        
        def not_exist(msg)
            puts "#{msg} no existe!"
        end

        def exist(msg)
            puts "#{msg} ya existe!"
        end

        def success(msg)
            puts "#{msg} con exito!"
        end

        def name_check_error()
            puts """
              Algun nombre ingresado es invalido! 
              Solo se pueden ingresar nombres compuesto con Letras y numeros!"""
        end
    end
end