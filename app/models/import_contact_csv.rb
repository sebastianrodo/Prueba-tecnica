class ImportContactCsv
  include CSVImporter

  model Contact

  column :name
  column :date_of_birth
  column :phone_number
  column :address
  column :credit_card_number
  column :credit_card_type
  column :email
  column :user_id
  column :csv_id
  column :created_at
  column :updated_at
end
