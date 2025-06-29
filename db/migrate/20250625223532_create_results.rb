class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.string :category
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
