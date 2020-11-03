require_relative "../tools"

module RN 
    module Models

        class Book
            extend Tool
            def self.create (name)
                begin
                
                rute = Paths.book_path(name.downcase())

                Dir.mkdir(rute)

                rescue Errno::EEXIST 
                puts "--------------------------------------------------------------------\n Ya existe el book '#{name}'! \n--------------------------------------------------------------------"
                else
                puts "--------------------------------------------------------------------\n Book '#{name}' creado exitosamente! \n--------------------------------------------------------------------"
                end
            end

            def self.delete(name)
                begin

                self.book_exist(name)

                rute_book = Paths.book_path(name)
                Dir.delete(rute_book)

                rescue Errno::ENOTEMPTY
                    

                    puts "La carpeta que desea borrar contiene notas, esta seguro que desea borrarla? (yes/no)"
                    
                    option = $stdin.gets

                    if option.match?(/y(?:es)?|1/)
                        FileUtils.rm_rf(rute_book)
                    end

                end
            end

            def self.delete_global()
                self.delete("global")
                self.create("global")
            end

            def self.list()
                rute = Paths.storage_root_path()
                puts "--------------------------------------------------------------------\n"
                Dir.each_child(rute) {|dir| puts dir}
                puts "--------------------------------------------------------------------\n"
            end
        end
    end
end