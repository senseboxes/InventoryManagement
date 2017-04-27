class CreateProdNamelists < ActiveRecord::Migration[5.0]
  def change
    create_table :prod_namelists do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
