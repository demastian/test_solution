class Upload < ActiveRecord::Base
  belongs_to :entity, polymorphic: true

  mount_uploader :file, GenericFileUploader
end
