module Paperclip
  class FileEncryptor < Processor

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
        # set contents attribute by reading the attachment file
        # move pointer back to start of file in case handled by other processors
        @file.rewind
        file_content = File.read(@file.path)

        # salt  = SecureRandom.random_bytes(64)
        # key   = ActiveSupport::KeyGenerator.new('password').generate_key(salt)
        # key_file = File.new("/home/drugsha/" + "#{salt}")
        crypt = ActiveSupport::MessageEncryptor.new(@options[:key])

        encrypted_file_content = crypt.encrypt_and_sign(file_content)

        new_file = Tempfile.new([@basename, "txt"].compact.join("."))
        new_file << encrypted_file_content
      rescue StandardError => e
        if @whiny
          raise Paperclip::Error, "There was an error processing the
           file contents for #{@basename} - #{e}"
        end
      end
    end
  end
end