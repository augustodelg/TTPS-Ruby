

module RN 
    module Models
        class Book
            extend Tool
            extend Output
            def self.book_path(book)
                return File.join(Paths.storage_root_path(), book)
            end
    
            def self.create (name)
                if self.book_not_exist(name)
                    Dir.mkdir(self.book_path(name))
                    self.success("Creacion de #{name}")
                    #puts "--------------------------------------------------------------------\n Book '#{name}' creado exitosamente! \n--------------------------------------------------------------------"    
                else self.exist(name)
                end

            end

            def self.delete(name)
                if self.book_exist(name)
                    begin
                    Dir.delete(self.book_path(name))
                    rescue Errno::ENOTEMPTY
                        puts "La carpeta que desea borrar contiene notas, esta seguro que desea borrarla? (yes/no)"
                        option = $stdin.gets
                        if option.match?(/y(?:es)?|1/) 
                            FileUtils.rm_rf(rute_book)
                            Output.success("Eliminacion de #{name}")
                        end
                    end
                    
                end    
            end

            def self.delete_global()
                self.delete("global")
                self.create("global")
            end

            def self.list()
                rute = Paths::STORAGE_ROOT
                array_books = Dir.children(rute) 
                Output.show(array_books)
            end

            def self.rename(old_name, new_name)

                if self.name_check(new_name)
                    if self.book_exist(old_name)
                        if self.book_not_exist(new_name)
                        #Genere the route of old path and new path
                        old_path = self.book_path(old_name)
                        new_path = self.book_path(new_name)
                        File.rename(old_path, new_path)
                        end
                    end
                else Output.name_check_error()
                end
            end
        end
    end
end