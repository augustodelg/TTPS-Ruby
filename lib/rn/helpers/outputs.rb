module RN
    module Helpers
        module Output

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
        end
    end
end