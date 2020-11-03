module RN

    class Paths
        STORATE_ROOT = "app"
        GOBAL_DIR_NAME = "global"

        def self.storage_root_path()
           return STORATE_ROOT 
        end

        def self.book_path(book)
            return File.join(STORATE_ROOT, book)
        end

        def self.book_gobal_path()
            return File.join(STORATE_ROOT, GOBAL_DIR_NAME)
        end

        def self.note_path(name, book)
            return File.join(STORATE_ROOT, book,"#{name}.rn")
        end

    end
    
end