module RN
    module Helpers
        module Paths
            STORAGE_ROOT = File.join(Dir.home,".my_rns")

            def self.storage_root_path()
            return STORAGE_ROOT 
            end

            def self.notes_extension
                '.rn'
            end
        end
    end
end