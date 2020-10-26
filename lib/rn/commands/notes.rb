require_relative "../tools"
require 'find'

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
        include Tool
        
        def call(title:,  **options)
          begin

            #Si no se ingreso un book es global
            !options[:book].nil? ? book = options[:book] : book = "global"

            self.find_note(title,book)
            self.name_check(title)

            File.open("./app/#{book}/#{title}.rn", 'w')
            
            rescue Errno::ENOENT 
              puts "--------------------------------------------------------------------\n El book indicado, '#{book}', no exite, por favor crealo antes! \n--------------------------------------------------------------------"
            else 
              puts "--------------------------------------------------------------------\n Nota creada correctamente! Su nota fue almacenada en el book '#{book}'\n--------------------------------------------------------------------"
          end
        end

        def find_note (name,book)
          begin
            if File.exist?("./app/#{book}/#{name}.rn")
              puts "--------------------------------------------------------------------\n La nota con el titulo '#{name}' ya existe! \n--------------------------------------------------------------------"
              abort
            else 
              return true
            end
              
          end
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

        include Tool

        def call(title:, **options)
          begin
            !options[:book].nil? ? book = options[:book] : book = "global"

            self.name_check(title)
            self.book_exist(book)

            File.delete("./app/#{book}/#{title}.rn")
              
            rescue Errno::ENOENT 
              puts "--------------------------------------------------------------------\n No exite la nota '#{title}'! \n--------------------------------------------------------------------"
            else 
              puts "--------------------------------------------------------------------\n Nota eliminada correctamente! Su nota fue eliminada del book '#{book}'\n--------------------------------------------------------------------"
          end
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
          book = options[:book]
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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

        include Tool

        def call(old_title:, new_title:, **options)
          begin
            !options[:book].nil? ? book = options[:book] : book = "global"
            #Chequeo si el nombre nuevo es correcto
            self.name_check(new_title)
            self.book_exist(book)

            File.rename("./app/#{book}/#{old_title}.rn","./app/#{book}/#{new_title}.rn")
            rescue Errno::ENOENT 
              puts "--------------------------------------------------------------------\n No exite la nota '#{old_title}'! \n--------------------------------------------------------------------"
            else
              puts "Cambio de nombre exitoso!"
          end
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

        include Tool

        def call(**options)
          !options[:book].nil? ? book = options[:book] : book = "global"
          #Chequeo si el nombre nuevo es correcto
          self.book_exist(book)
          book == "global" ? rute = './app' : rute = "./app/#{book}"
          #global = options[:global]
          puts "Note list of : #{book}\n--------------------------------------------------------------------"
          Find.find(rute) do |f|
            if File.file?(f) 
              puts File.basename(f) 
            end
          end
          puts "--------------------------------------------------------------------"
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

        include Tool

        def call(title:, **options)
          begin
            !options[:book].nil? ? book = options[:book] : book = "global"
            #Chequeo si el nombre nuevo es correcto
            self.name_check(title)
            self.book_exist(book)

            note = File.read("./app/#{book}/#{title}.rn")
            rescue Errno::ENOENT 
              puts "--------------------------------------------------------------------\n No exite la nota '#{title}'! O no indico el Book al que pertenece!\n--------------------------------------------------------------------"
            else
              puts "NOTE : #{title}\n--------------------------------------------------------------------\n#{note}\n--------------------------------------------------------------------"
          end
        end
      end
    end
  end
end
