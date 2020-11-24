module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          options[:book].nil? ? note = Models::Note.new(title) : note = Models::Note.new(title, book: Models::Book.new(options[:book]))
          puts note.create()
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          options[:book].nil? ? note = Models::Note.new(title) : note = Models::Note.new(title, book: Models::Book.new(options[:book]))
          puts note.delete()
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          options[:book].nil? ? note = Models::Note.new(title) : note = Models::Note.new(title, book: Models::Book.new(options[:book]))
          puts note.edit()
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          if options[:book].nil?
            old_note = Models::Note.new(old_title)
            future_note = Models::Note.new(new_title)
          else
            old_note = Models::Note.new(old_title, book: Models::Book.new(options[:book]))
            future_note = Models::Note.new(new_title, book: Models::Book.new(options[:book]))
          end
          puts old_note.retitle(future_note)
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          if global 
            # Export all notes from global dir
            notes = (Models::Book.global).notes
          elsif book.nil?
            # Export all notes form all books
            notes = Models::Book.all_books_notes
          else
            notes = (Models::Book.new(book)).notes
          end
          notes != false ? Helpers::Output.show_info(notes) : (puts notes)
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          options[:book].nil? ? note = Models::Note.new(title) : note = Models::Note.new(title, book: Models::Book.new(options[:book]))
          content = note.show()
          content != false ? Output.show_info(content) : (puts content)
        end
      end

      class Export < Dry::CLI::Command
        desc 'Export notes'

        argument :title, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'Export only notes from the global book'

        example [
          '                             # Export all notes titled from all books',
          '--global                     # Export all notes titled from the gobal book',
          '--book BookName              # Export all notes from the book "BookName"',
          'todo                         # Export a note titled "todo" from the global book',
          '"Name note" --book "My book" # Export a note titled "Name note" from the book "My book"',
          'aNote --book Memoires        # Export a note titled "aNote" from the book "Memoires"',
        ]

        def call(**options)
          # TODO MAKE FILETE OF THES METHODS
          title = options[:title]
          book = options[:book]
          global = options[:global]
          if global
            (Models::Book.global).export
          else 
            if not book.nil? 
              if not title.nil?
                # Export a note from a specific book
                (Models::Note.new(title,book: Models::Book.new(book))).export
              else
                (Models::Book.new(book)).export
              end
            elsif not title.nil?
              #Export a note from global book
              (Models::Note.new(title)).export
            else
              Models::Book.export_all_books_notes
            end
          end
        end
      end
    end
  end
end