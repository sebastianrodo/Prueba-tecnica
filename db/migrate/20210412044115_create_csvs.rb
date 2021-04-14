class CreateCsvs < ActiveRecord::Migration[6.0]
  def change
    create_table :csvs do |t|
      t.string  :state, null: false
      t.references :user, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
