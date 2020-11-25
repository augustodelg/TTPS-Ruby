module RN
    module Helpers
        module Output
            # ERROR_TYPE = {
            #     :2 => "No existe el libro",
            #     :3 => "No existe la nota origen!",
            #     :4 => "No existe la nota destino!",
            #     :5 => "La nota ya existe!",
            #     :7 => "El libro ya existe!",
            #     :8 => "Algun nombre ingresado es invalido! Solo se pueden ingresar nombres compuesto con Letras y numeros!"
            # }

            def self.show_info(element)
                puts "--------------------------------------------------------------------\n"
                puts element
                puts "--------------------------------------------------------------------\n"
            end
            
            def self.not_exist(msg)
                puts "#{msg} no existe!"
            end

            def self.exist(msg)
                puts "#{msg} ya existe!"
            end

            def self.success(msg)
                puts "#{msg} con exito!"
            end

            def self.name_check_error()
                puts """
                Algun nombre ingresado es invalido! 
                Solo se pueden ingresar nombres compuesto con Letras y numeros!"""
            end

            def self.error()
                # puts ERROR_TYPE[number_error]
                puts """Ocurrio un error al ejecutar el comando!\nCorrobore que esta ingresando nombres validos (solo numeros y letras) y que las notas y/o libros indicados (en caso de corresponder) existan! """
            end
        end
    end
end