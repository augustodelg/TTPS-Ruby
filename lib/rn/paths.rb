module RN

    class Paths
        STORAGE_ROOT = "app2"
        GLOBAL_DIR_NAME = "global/"

        def self.storage_root_path()
           return STORAGE_ROOT 
        end

        def self.book_path(book)
            return File.join(STORAGE_ROOT, book)
        end

        def self.book_global_path()
            return File.join(STORAGE_ROOT, GLOBAL_DIR_NAME)
        end

        def self.note_path(name, book)
            return File.join(STORAGE_ROOT, book,"#{name}.rn")
        end

    end
    
end