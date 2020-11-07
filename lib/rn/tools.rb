module RN
  module Tool

      def name_check?(title)
        if !title.match?(/^[A-Za-z0-9]+$/)
          return false
        end
        return true
      end 
      #Is necessary need indicate what return me
      def book_exist?(book,tell_me)
        rute = Paths.book_path(book)
        if File.exist?(rute) && File.directory?(rute)
            return tell_me
        end 
        return !tell_me
      end

      def note_exist?(name, book, tell_me)
        rute = Paths.note_path(name,book)
          if File.exist?(rute ) && File.file?(rute)
            return tell_me
          end
          return !tell_me
      end
          
  end
end
