module RN

    module Paths
        STORAGE_ROOT = File.join(Dir.home,".my_rns")
        GLOBAL_DIR_NAME = "global"

        def self.storage_root_path()
           return STORAGE_ROOT 
        end

        def self.book_path(book)
            return File.join(STORAGE_ROOT, book)
        end

        #This method is not used for Book class
        def self.note_path(name, book)
            return File.join(STORAGE_ROOT, book,"#{name}.rn")
        end

        def self.book_global_path()
            return File.join(STORAGE_ROOT, GLOBAL_DIR_NAME)
        end
        
    end
    
end