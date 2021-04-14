module CsvsHelper
  def get_credit_card_brand(number)
    detector = CreditCardValidations::Detector.new(number)
    detector.brand_name
  end

  def file_name(file_object)
    File.basename(url_for(file_object.file))
  end

  def self.parse_csv_file(csv)
    file_rows = []

    CSV.parse(csv.file.download) do |row|
      file_rows << row
    end

    file_rows.from(1)
  end
end
