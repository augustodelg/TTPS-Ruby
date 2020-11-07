module RN

    module Paths
        STORAGE_ROOT = "app"
        GLOBAL_DIR_NAME = "global/"

        def self.book_global_path()
            return File.join(STORAGE_ROOT, GLOBAL_DIR_NAME)
        end
        
    end
    
end