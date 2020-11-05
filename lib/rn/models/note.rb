module RN 
  module Models
    class Note

      extend Tool
      
      def self.create(title, book)

          #Valid if the name is correct and if the book exists
          if self.name_check(title)
            if self.book_exist(book)
              if self.note_exist(title,book)
                #Genre the route
                path = Paths.note_path(title,book)
                #created the file
                File.open( path , 'w')
                puts "--------------------------------------------------------------------\n Nota creada correctamente! Su nota fue almacenada en el book '#{book}'\n--------------------------------------------------------------------"
              end
            end
          end
        end
        
      def self.delete(title, book)
      
        #Valid if the name is correct and if the book exists
        if self.name_check(title)
          if self.book_exist(book)
            if self.note_not_exist(title, book)
              #Genre the route
              path = Paths.note_path(title,book)
              #Deleted the file
              File.delete(path)
              puts "--------------------------------------------------------------------\n Nota eliminada correctamente! Su nota fue eliminada del book '#{book}'\n--------------------------------------------------------------------"
            end
          end
        end
      end

      def self.retitle(old_title, new_title, book)
        
        #Valid if the name is correct and if the book exists
        if self.name_check(new_title)
          if self.book_exist(book)
            if self.note_not_exist(old_title)
              #Genere the route of old path and new path
              old_path = Paths.note_path(old_title, book)
              new_path = Paths.note_path(new_title, book)

              File.rename(old_path, new_path)

              puts "Cambio de nombre exitoso!"
            end
          end
        end
      end
      
      def self.list(book, rute)

        unless book != "All"
            exist = true
          else
            exist = self.book_exist(book)
        end

        if exist
          puts "Note list of : #{book}\n--------------------------------------------------------------------"
          Dir.glob(File.join(rute + "*.rn")) do |f|
            if File.file?(f)
              book == "All" ? output = (f[4..]).sub('/', ' <--- ') : output = File.basename(f)
              puts output
            end
          end
          puts "--------------------------------------------------------------------"
        end
      end

      #TODO- Fix that note do be exist for be edit 
      def self.edit(title,book)
        
        if self.name_check(title)
          if self.book_exist(book)
            if self.note_not_exist(title,book)
              rute = Paths.note_path(title, book)
              TTY::Editor.open(rute ,command:"nano -w")
            end
          end
        end
      end

      def self.show(title,book)
          #Checking if the new name is correct
          if self.name_check(title)
            if self.book_exist(book)
              if self.note_not_exist(title,book)
                rute = Paths.note_path(title, book)
                note = File.read(rute)
                puts "NOTE : #{title}\n--------------------------------------------------------------------\n#{note}\n--------------------------------------------------------------------"
              end
            end
          end
      end
    end
  end
end
