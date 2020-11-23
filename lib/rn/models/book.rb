module RN 
    module Models
        class Book
            
            #extend Output
            GLOBAL_BOOK_NAME = 'global'

            attr_accessor :name

            extend RN::Tool

            def initialize(name)
                self.name = name
            end
            
            #Class methods

            def self.global
                new GLOBAL_BOOK_NAME
            end

            def self.list()
                rute = Paths::STORAGE_ROOT
                array_books = Dir.children(rute) 
                #self.show_info(array_books)
                return array_books
            end

            def path()
                return File.join(Paths::STORAGE_ROOT, self.name)
            end

            def exist?()
                return File.exist?(self.path())
            end

            def create()
                if self.name_check?(self.name)
                    if not self.exist?()
                        Dir.mkdir(Paths.book_path(name))
                        return True
                    end
                end
                return False
            end

            def delete_all()
                FileUtils.rm_rf(rute_book)
            end

            def self.delete(name)
                if self.name_check?(name)
                    if self.exist?()
                        rute_book = Paths.book_path(name)
                        Dir.delete(rute_book)
                        return True   
                    end
                return False
                end
            end

            def self.delete_global()
                self.delete("global")
                self.create("global")
            end

            def self.rename(old_name, new_name)

                if self.name_check?(new_name) && self.name_check?(old_name)
                    if self.exist?()
                        old_book = new (old_name)
                        if not old_book.exist?()
                            #Genere the route of old path and new path
                            old_path = Paths.book_path(old_name)
                            new_path = Paths.book_path(new_name)
                            File.rename(old_path, new_path)
                            return True
                        end
                    end
                end
                return False
            end
        end
    end
end
