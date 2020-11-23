module RN
  module Validator

      def name_check?(title)
        return title.match?(/^[A-Za-z0-9\s]+$/)
      end 
      
      #Is necessary need indicate what return me
      def book_exist?(book,tell_me)
        rute = Paths.book_path(book)
        (File.exist?(rute) && File.directory?(rute)) ? tell_me : !tell_me
      end

      def note_exist?(name, book, tell_me)
        rute = Paths.note_path(name,book)
          (File.exist?(rute ) && File.file?(rute)) ? tell_me : !tell_me
      end
          
  end
end
