module RN 
  module Models
    class Note

      # extend Tool
      # extend Output

      attr_accessor :title, :content, :book
      
      def initialize(title, content, book: nil)
        self.title = title
        self.content = content
        self.book = book || Book.global
      end

      # Class methods
      def self.from_file(path, book: nil)
        title = File.basename(path)
        content = File.read(path)
        new(title, content, book: book)
      end

      

      # 
      def create(title, book)
          #Valid if the name is correct and if the book exists
          if self.name_check?(self.title)
            if self.book_exist?(self.book,true)
              if self.note_exist?(self.title,self.book, false)
                #Genre the route
                path = Paths.note_path(title,book)
                #created the file
                File.open( path , 'w')
                self.success("Nota #{title} creada")
              else self.exist(title)
              end
            else self.not_exist(book)
            end
          else self.name_check_error()
          end
      end
        
      def self.delete(title, book)
        #Valid if the name is correct and if the book exists
        if self.name_check?(title)
          if self.book_exist?(book,true)
            if self.note_exist?(title, book, true)
              #Genre the route
              path = Paths.note_path(title,book)
              #Deleted the file
              File.delete(path)
              self.success("Nota #{title} eliminada")
              
            else self.not_exist(title)
            end
          else self.not_exist(book)
          end
        else self.name_check_error()
        end
      end

      def self.retitle(old_title, new_title, book) 
        #Valid if the name is correct and if the book exists
        if self.name_check?(new_title)
          if self.book_exist?(book,true)
            if self.note_exist?(old_title, book, true)
              if self.note_exist?(new_title, book, false)
                #Genere the route of old path and new path
                old_path = Paths.note_path(old_title, book)
                new_path = Paths.note_path(new_title, book)
                File.rename(old_path, new_path)
                self.success("Cambio de nombre de #{old_title} a #{new_title} ")
              else self.exist(new_title)
              end
            else self.not_exist(old_title)
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
          notes = Dir.glob(File.join(rute, "*.rn")).map{|each| book == "All" ? each = (each[18..]).sub('/', ' <-- ') : each = File.basename(each)}
          self.show_info(notes)
        else self.not_exist(book)
        end
      end

      def self.edit(title,book)
        
        if self.name_check?(title)
          if self.book_exist?(book,true)
            if self.note_exist?(title,book, true)
              rute = Paths.note_path(title, book)
              TTY::Editor.open(rute ,command:"nano -w")
            end
          end
        end
      end

      def self.show(title,book)
          if self.name_check?(title)
            if self.book_exist?(book,true)
              if self.note_exist?(title,book, true)
                note = File.read(Paths.note_path(title, book))
                self.show_info(note)
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
