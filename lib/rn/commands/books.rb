# TODO - MODIFY THIS CLASS, FOR IMPLEMENT A NEW MODEL.
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
          book = Models::Book.new(name)
          puts book.create()
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          begin
            global = options[:global]
            global ? book = Models::Book.global : book = Models::Book.new(name)
            Output.success("Eliminacion de #{book.name}") if book.delete()
            #If the book not empty, need ask if secure delete this
            rescue Errno::ENOTEMPTY
              puts "La carpeta que desea borrar contiene notas, esta seguro que desea borrarla? (yes/no)"
              option = $stdin.gets
              if option.match?(/y(?:es)?|1/) 
                Output.success("Eliminacion de #{name}") if book.delete_all()
              end
          end
          # Sampling that was eliminated if you enter yes, in case of be need puts yes. 
          #Output.success("Eliminacion de #{name}")  if !option.match?(/n(?:o)?|1/) && option.match?(/y(?:es)?|1/) 
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]
        def call(*)
          Output.show_info (Models::Book.list())
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          book =  Models::Book.new (old_name)
          future_book = Models::Book.new (new_name)
          puts book.rename(future_book)
        end
      end
    end
  end
end
