module RN 
  module Models
    class Note

      extend Tool
      extend Output
      
      def self.note_path(name, book)
        return File.join(Paths::STORAGE_ROOT, book,"#{name}.rn")
      end

      def self.create(title, book)

          #Genre the route
          path_book = self.note_path(title,book)

          #Valid if the name is correct and if the book exists
          if self.name_check(title)
            if self.book_exist?(rute,true)
              if self.note_exist(title,book)
                
                #created the file
                File.open( path_ , 'w')
                #puts "--------------------------------------------------------------------\n Nota creada correctamente! Su nota fue almacenada en el book '#{book}'\n--------------------------------------------------------------------"
                self.success("Nota #{title} creada")
              else self.exist(title)
              end
            else self.not_exist(book)
            end
          else self.name_check_error()
          end
      end
        
      def self.delete(title, book)
        #Genre the route
        path = self.note_path(title,book)

        #Valid if the name is correct and if the book exists
        if self.name_check(title)
          if self.book_exist?(book,true)
            if self.note_not_exist(title, book)
              
              #Deleted the file
              File.delete(path)
              self.success("Nota #{title} eliminada")
              #puts "--------------------------------------------------------------------\n Nota eliminada correctamente! Su nota fue eliminada del book '#{book}'\n--------------------------------------------------------------------"
            else self.not_exist(title)
            end
          else self.not_exist(book)
          end
        else self.name_check_error()
        end
      end

      def self.retitle(old_title, new_title, book)
        
        #Valid if the name is correct and if the book exists
        if self.name_check(new_title)
          if self.book_exist?(book,true)
            if self.note_not_exist(old_title)
              #Genere the route of old path and new path
              old_path = self.note_path(old_title, book)
              new_path = self.note_path(new_title, book)

              File.rename(old_path, new_path)
              self.success("Cambio de nombre")
            else self.not_exist(title)
            end
          else self.not_exist(book)
          end
        else self.name_check_error()
        end
      end
      
      def self.list(book, rute)

        unless book != "All"
            exist = true
          else
            exist = self.book_exist?(book,true)
        end

        if exist
          notes = Dir.glob(File.join(rute + "*.rn")).map{|each| book == "All" ? each = (each[4..]).sub('/', ' <--- ') : each = File.basename(each)}
          self.show(notes)
        else self.not_exist(book)
        end
      end

      #TODO- Fix that note do be exist for be edit 
      def self.edit(title,book)
        
        if self.name_check(title)
          if self.book_exist?(book,true)
            if self.note_not_exist(title,book)
              rute = self.note_path(title, book)
              TTY::Editor.open(rute ,command:"nano -w")
            end
          end
        end
      end

      def self.show(title,book)
          #Checking if the new name is correct
          if self.name_check(title)
            if self.book_exist?(book,true)
              if self.note_not_exist(title,book)
                rute = self.note_path(title, book)
                note = File.read(rute)
                puts "NOTE : #{title}\n--------------------------------------------------------------------\n#{note}\n--------------------------------------------------------------------"
              else self.not_exist(title)
              end
            else self.not_exist(book)
            end
          else self.name_check_error()
          end
      end
    end
  end
end
