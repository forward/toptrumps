class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :url
      t.text :html

      t.timestamps
    end
  end
end
