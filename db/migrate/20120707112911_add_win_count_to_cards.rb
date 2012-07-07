class AddWinCountToCards < ActiveRecord::Migration
  def change
    add_column :cards, :win_count, :integer, :default => 0
  end
end
