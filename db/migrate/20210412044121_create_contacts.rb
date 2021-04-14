class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.date :date_of_birth, null: false
      t.string :phone_number, null: false
      t.string :address, null: false
      t.string :encrypted_credit_card_number, null: false
      t.string :encrypted_credit_card_number_iv, null: false
      t.string :credit_card_type, null: false
      t.string :email, null: false
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.references :csv, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
