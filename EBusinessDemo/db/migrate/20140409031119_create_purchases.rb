class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.date :purchase_time

      t.timestamps
    end
  end
end
