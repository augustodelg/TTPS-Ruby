module RN
    module Helpers
        module Paths
            STORAGE_ROOT = File.join(Dir.home,".my_rns")

            def self.notes_extension
                '.rn'
            end

        end
    end
end