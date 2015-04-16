class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true

  # document uploads
  has_attached_file :document,
                    :styles => {
                      :encrypted => {:processors => [:file_encryptor],
                                        key: File.read("#{Rails.root}/key")}
                    }

  # styles: lambda { |attachment| attachment.instance.
  #                    documentable_type.constantize.set_styles  }
  # "application/msword", "application/octet-stream", "text/plain"

  validates_attachment :document,
            :content_type => { :content_type => ["application/pdf"] },
            :size => { :in => 0..5.megabytes },
            :file_name => { :matches => [/pdf\Z/] }

  # This must be declared after the has_attached_file declaration
  after_save :clean_up_files

  def decrypt(key=File.read("#{Rails.root}/key"))
    crypt = ActiveSupport::MessageEncryptor.new(key)
    encrypted_content = File.read(self.document.path(:encrypted))
    original_content = crypt.decrypt_and_verify(encrypted_content)
    f = File.open(self.document.path, "w+")
    f << original_content
    f.close
  end

  def set_key(password="password")
    salt  = SecureRandom.random_bytes(64)
    key   = ActiveSupport::KeyGenerator.new(password).generate_key(salt)
  end

  def clean_up_files
    if self.documentable.class == Offer
      File.truncate(self.document.path, 0)
    else
      path = Pathname.new(self.document.path(:encrypted))
      FileUtils.rm(path.to_s)
      path.parent.rmdir
    end

  end

  # Passing lambda to styles..Something wrong with attachement initializer probably
  # def set_styles
  #   if self.documentable_type == "Offer"
  #     { encrypted: {processors: [:file_encryptor], key: File.read("#{Rails.root}/key")} }
  #   else
  #     { original: {processors: [:no_processor]} }
  #   end
  # end
end