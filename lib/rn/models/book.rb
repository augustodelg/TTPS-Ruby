

module RN 
    module Models
        class Book
            extend Tool
            def self.create (name)
                if self.book_not_exist(name)
                    rute = Paths.book_path(name)
                    Dir.mkdir(rute)
                    puts "--------------------------------------------------------------------\n Book '#{name}' creado exitosamente! \n--------------------------------------------------------------------"    
                end

            end

            def self.delete(name)
                if self.book_exist(name)
                    begin
                    rute_book = Paths.book_path(name)
                    Dir.delete(rute_book)
                    rescue Errno::ENOTEMPTY
                        puts "La carpeta que desea borrar contiene notas, esta seguro que desea borrarla? (yes/no)"
                        option = $stdin.gets
                        option.match?(/y(?:es)?|1/) if FileUtils.rm_rf(rute_book)
                
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

            def self.rename(old_name, new_name)

                if self.name_check(new_name)
                    if self.book_exist(old_name)
                        if self.book_not_exist(new_name)
                        #Genere the route of old path and new path
                        old_path = Paths.book_path(old_name)
                        new_path = Paths.book_path(new_name)
                        File.rename(old_path, new_path)
                        end
                    end
                end
            end
        end
    end
end