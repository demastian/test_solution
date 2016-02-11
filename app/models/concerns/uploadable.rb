module Uploadable
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def has_file(attr_name)
      has_one :"#{attr_name}_upload",
        -> { where(attribute_name: attr_name) },
        class_name: 'Upload',
        as: :entity,
        autosave: true

      define_method attr_name do
        send("#{attr_name}_upload").try(:file)
      end

      define_method "#{attr_name}=" do |file|
        send("build_#{attr_name}_upload") if send("#{attr_name}_upload").blank?
        send("#{attr_name}_upload").file = file
      end
    end
  end
end
