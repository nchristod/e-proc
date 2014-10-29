module Paperclip
  class FileEncryptor < Processor
    
    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(attachment.instance.document_file_name)
      @basename       = File.basename(@file.path, @current_format)
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make
      begin
        # new record, set contents attribute by reading the attachment file
        if(@instance.new_record?)
          @file.rewind # move pointer back to start of file in case handled by other processors
          file_content = File.read(@file.path)

          salt  = SecureRandom.random_bytes(64)
          key   = ActiveSupport::KeyGenerator.new('password').generate_key(salt)
          crypt = ActiveSupport::MessageEncryptor.new(key)

          encrypted_file_content = crypt.encrypt_and_sign(file_content)
          @instance.document.send("#{@options[:contents]}=", encrypted_file_content)
        else                                                     
          # existing record, set contents by reading contents attribute
          file_content = @instance.send(@options[:contents])
          # create new file with contents from model
          tmp = Tempfile.new([@basename, @current_format].compact.join("."))
          tmp << file_content
          tmp.flush 
          @file = tmp
        end         
                 
        @file
      rescue StandardError => e
        raise Paperclip::Error, "There was an error processing the file contents for #{@basename} - #{e}" if @whiny
      end
    end
  end
end