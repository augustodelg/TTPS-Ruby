module RN 
    module Models
        class Book
            
            #extend Output
            GLOBAL_BOOK_NAME = 'global'

            attr_accessor :name, :errors

            include RN::Helpers::Validator

            def initialize(name)
                self.name = name
                self.errors = []
            end

            def to_s
                self.name
            end
            
            # Class methods

            def self.global
                new GLOBAL_BOOK_NAME
            end

            def self.list()
                books = Dir.children(Helpers::Paths::STORAGE_ROOT).map do |book_name|
                    new book_name
                end
                return books 
            end

            def self.all_books_notes
                all_books = self.list
                all_notes = []
                for book in all_books do
                    all_notes.append(book.notes)
                end
                return all_notes
            end

            # Instance methods

            def path
                File.join(Helpers::Paths::STORAGE_ROOT, self.name)
            end

            def exist?()
                File.exist?(self.path)
            end

            def global?
                name == GLOBAL_BOOK_NAME
            end

            def create()
                if self.name_check?(self.name)
                    if not self.exist?()
                        Dir.mkdir(self.path)
                        return true
                    end
                end
                return false
            end

            def delete_all()
                FileUtils.rm_rf(path)
                self.create() if self.global?
            end

            def delete()
                if self.name_check?(self.name)
                    if self.exist?()
                        Dir.delete(path)
                        self.create() if self.global?
                        return true   
                    end
                end
                return false
            end

            def rename(future_book)

                if self.name_check?(self.name) 
                    if self.exist?()
                        if not future_book.exist?() && future_book.name_check?(future_book.name)
                            #Change the name of actual book
                            File.rename(self.path, future_book.path)
                            return true
                        end
                    end
                end
                return false
            end

            def notes
                if self.exist?
                    return Dir["#{path}/*#{Helpers::Paths.notes_extension}"].map do |note_path|
                        Note.from_file(note_path, book: self)
                    end
                end
                return false
            end
            
        end
    end
end
