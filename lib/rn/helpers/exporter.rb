module RN
    module Helpers
      class Exporter
        attr_accessor :path,:tool_exporter
      
        def initialize(path: Dir.pwd)
          self.path = File.join(path, "export - #{(Time.now).to_s}")
          self.tool_exporter =  Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
          Dir.mkdir(path)
        end

        def create_path
            Dir.mkdir(self.path)
        end

        def export_note(aNote)
            begin
            File.write(File.join(self.path,(aNote.book).name, "#{aNote.title}.html"), self.tool_exporter.render(aNote.content))
            rescue Errno::ENOENT
                Dir.mkdir(File.join(self.path,(aNote.book).name))
                retry
            end
        end

        def export_all(notes)
            for note in notes.flatten do
                self.export_note(note)
            end
        end

      end
    end
  end
  