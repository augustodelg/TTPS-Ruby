require_relative "../tools"

module RN 
  module Models
    class Note

      extend Tool
      
      def self.create(title, book)
          begin

            
            #Valid if the name is correct and if the book exists
            self.name_check(title)
            self.book_exist(book)
            self.note_exist(title,book)

            path = Paths.note_path(title,book)

            File.open( path , 'w')
            
            rescue Errno::ENOENT 
              puts "--------------------------------------------------------------------\n El book indicado, '#{book}', no exite, por favor crealo antes! \n--------------------------------------------------------------------"
            else 
              puts "--------------------------------------------------------------------\n Nota creada correctamente! Su nota fue almacenada en el book '#{book}'\n--------------------------------------------------------------------"
          end
        end
        
      

      def self.delete(title, book)
        begin
          
          #Valid if the name is correct and if the book exists
          self.name_check(title)
          self.book_exist(book)
          
          #Genre the route
          path = Paths.note_path(title,book)

          #Deleted the file
          File.delete(path)
            
          rescue Errno::ENOENT 
            puts "--------------------------------------------------------------------\n No exite la nota '#{title}'! \n--------------------------------------------------------------------"
          else 
            puts "--------------------------------------------------------------------\n Nota eliminada correctamente! Su nota fue eliminada del book '#{book}'\n--------------------------------------------------------------------"
        end
      end

      def self.retitle(old_title, new_title, book)
        begin

          #Valid if the name is correct and if the book exists
          self.name_check(new_title)
          self.book_exist(book)

          #Genre the route of old path and new path
          old_path = Paths.note_path(old_title, book)
          new_path = Paths.note_path(new_title, book)

          File.rename(old_path, new_path)

          rescue Errno::ENOENT 
            puts "--------------------------------------------------------------------\n No exite la nota '#{old_title}'! \n--------------------------------------------------------------------"
          else
            puts "Cambio de nombre exitoso!"
        end
      end
      
      def self.list(book, global)

        if global 
          rute = Paths.book_gobal_path()
          book = "global"
        elsif book.nil?
          rute = Paths.book_path("*/")
          book = "All"
        else
          rute = Paths.book_path(book)
        end

        self.book_exist(book) if book != "All"

        puts "Note list of : #{book}\n--------------------------------------------------------------------"
        Dir.glob(File.join(rute + "*.rn")) do |f|
          if File.file?(f)
            book == "All" ? output = (f[4..]).sub('/', ' <--- ') : output = File.basename(f)
            puts output
          end
        end
        puts "--------------------------------------------------------------------"
      end

      #TODO- Fix that note do be exist for be edit 
      def self.edit(title,book)

        self.name_check(title)
        self.book_exist(book)

        self.note_not_exist(title,book)

        TTY::Editor.open("./app/#{book}/#{title}.rn",command:"nano -w")
        TTY::Reader::InputInterrupt
      end

      def self.show(title,book)
        begin
          
          #Checking if the new name is correct
          self.name_check(title)
          self.book_exist(book)

          rute = Paths.note_path(title, book)

          note = File.read(rute)
          rescue Errno::ENOENT 
            puts "--------------------------------------------------------------------\n No exite la nota '#{title}'! O no indico el Book al que pertenece!\n--------------------------------------------------------------------"
          else
            puts "NOTE : #{title}\n--------------------------------------------------------------------\n#{note}\n--------------------------------------------------------------------"
        end
      end
    end
  end
end
