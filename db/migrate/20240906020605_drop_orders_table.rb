class DropOrdersTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :orders
  end

  def down
    create_table :orders do |t|
      t.string :name
      t.integer :price
      # 他の必要なカラムも再作成する場合はここに記述
      t.timestamps
    end
  end
end