class AddDisregardDateToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :disregard_date, :boolean, default: false
  end
end
