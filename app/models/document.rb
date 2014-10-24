class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true

  # document uploads
  has_attached_file :document, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment :document, 
            :content_type => { :content_type => ["application/pdf", "application/msword", "application/octet-stream"] },
            :size => { :in => 0..5.megabytes },
            :file_name => { :matches => [/pdf\Z/, /doc\Z/] }

end