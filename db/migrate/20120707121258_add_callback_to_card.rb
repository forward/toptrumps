class AddCallbackToCard < ActiveRecord::Migration
  def change
    add_column :cards, :callback, :text
  end
end
