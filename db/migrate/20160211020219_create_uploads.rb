class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.belongs_to :entity, polymorphic: true
      t.string :file
      t.string :attribute_name

      t.timestamps null: false
    end
  end
end
