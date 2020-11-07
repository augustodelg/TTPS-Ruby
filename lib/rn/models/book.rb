module RN 
    module Models
        class Book
            extend Tool
            extend Output
    
            def self.create (name)
                if self.name_check?(name)
                    if self.book_exist?(name, false)
                        Dir.mkdir(Paths.book_path(name))
                        self.success("Creacion de #{name}")
                    else self.exist(name)
                    end
                else self.name_check_error()
                end
            end

            def self.delete(name)
                if self.name_check?(name)
                    if self.book_exist?(name, true)
                        begin
                        rute_book = Paths.book_path(name)
                        Dir.delete(rute_book)
                        #If the book not empty, need ask if secure delete this
                        rescue Errno::ENOTEMPTY
                            puts "La carpeta que desea borrar contiene notas, esta seguro que desea borrarla? (yes/no)"
                            option = $stdin.gets
                            if option.match?(/y(?:es)?|1/) 
                                FileUtils.rm_rf(rute_book)
                            end
                        end
                        # Sampling that was eliminated if you enter yes, in case of be need puts yes. 
                        self.success("Eliminacion de #{name}")  if !option.match?(/n(?:o)?|1/) && option.match?(/y(?:es)?|1/) 
                    else self.not_exist(name)
                    end    
                else self.name_check_error()
                end
            end

            def self.delete_global()
                self.delete("global")
                self.create("global")
            end

            def self.list()
                rute = Paths::STORAGE_ROOT
                array_books = Dir.children(rute) 
                self.show_info(array_books)
            end

            def self.rename(old_name, new_name)

                if self.name_check?(new_name)
                    if self.book_exist?(old_name, true)
                        if self.book_exist(new_name, false)
                        #Genere the route of old path and new path
                        old_path = Paths.book_path(old_name)
                        new_path = Paths.book_path(new_name)
                        File.rename(old_path, new_path)
                        end
                    end
                else self.name_check_error()
                end
            end
        end
    end
end