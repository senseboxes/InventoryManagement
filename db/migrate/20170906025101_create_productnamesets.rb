class CreateProductnamesets < ActiveRecord::Migration[5.1]
  def change
    create_table :productnamesets do |t|
      t.string :productname
      t.text :description

      t.timestamps
    end
  end
end
