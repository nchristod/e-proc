module Paperclip
  class NoProcessor < Processor

    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(attachment.instance.document_file_name)
      @basename       = File.basename(@file.path, @current_format)
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make
      begin
        @file.rewind
        file_content = File.read(@file.path)
        Tempfile.new([@basename, "txt"].compact.join(".")) << file_content
      rescue StandardError => e
        raise Paperclip::Error, "There was an error processing the file contents for #{@basename} - #{e}" if @whiny
      end
    end
  end
end