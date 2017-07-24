class CreateWikis < ActiveRecord::Migration[5.1]
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user

      t.timestamps
    end
    add_index :wikis, :user
  end
end
