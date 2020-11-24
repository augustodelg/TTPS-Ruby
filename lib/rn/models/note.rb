module RN 
  module Models
    class Note

      include RN::Helpers::Validator
      # extend Output

      attr_accessor :title, :book
      
      def initialize(title, book: nil)
        self.title = title
        self.book = book || Book.global
      end

      def to_s
        self.title
      end

      # Class methods
      def self.from_file(path, book: nil)
        title = File.basename(path).gsub(Helpers::Paths.notes_extension, "")
        new(title, book: book)
      end

      # Instance methods
      def content
        File.read(path)
      end

      def filename
        title + Helpers::Paths.notes_extension
      end

      def path
        File.join(book.path,filename)
      end

      def exist?
        File.exist?(path)
      end

      def create()
          #Valid if the name is correct and if the book exists
          if self.name_check?(self.title)
            if (self.book).exist?()
              if not self.exist?()
                #created the file
                File.open(self.path , 'w')
                # self.success("Nota #{title} creada")
                return true
              end
            end
          end
          return false
      end
        
      def delete()
        #Valid if the name is correct and if the book exists
        if self.name_check?(self.title)
          if (self.book).exist?
            if self.exist?
              #Deleted the file
              File.delete(self.path)
              #self.success("Nota #{title} eliminada")
              return true
            end
          end
        end
        return false
      end

      def retitle(future_note) 
        #Valid if the name is correct and if the book exists
        if self.name_check?(self.title)
          if (self.book).exist?
            if self.exist?
              if not future_note.exist?
                #Genere the route of old path and new path
                File.rename(self.path, future_note.path)
                #self.success("Cambio de nombre de #{old_title} a #{new_title} ")
                return true
              end
            end
          end
        end
        return false
      end

      def edit()
        
        if self.name_check?(self.title)
          if (self.book).exist?
            if self.exist?
              TTY::Editor.open(self.path ,command:"nano -w")
              return true
            end
          end
        end
        return false
      end

      def show()
          if self.name_check?(self.title)
            if (self.book).exist?()
              if self.exist?()
                return self.content
              end
            end
          end
          return false
      end
      def export
        if self.name_check?(self.title)
          if (self.book).exist?()
            if self.exist?()
              exporter = Helpers::Exporter.new()
              exporter.export_note(self)
              return true
            end
          end
        end
        return false
      end
    end
  end
end
