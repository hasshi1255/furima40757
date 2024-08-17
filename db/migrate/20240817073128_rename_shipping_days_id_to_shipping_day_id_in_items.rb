class RenameShippingDayIdToShippingDaysIdInItems < ActiveRecord::Migration[7.0]
  def change
    # カラムが存在しない場合はエラーを防ぐ
    if column_exists?(:items, :shipping_day_id)
      rename_column :items, :shipping_day_id, :shipping_days_id
    end
  end
end