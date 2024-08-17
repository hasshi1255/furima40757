class RenameShippingDayIdToShippingDaysIdInItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :shipping_day_id, :shipping_days_id
  end
end