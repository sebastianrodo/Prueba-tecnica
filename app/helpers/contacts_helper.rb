module ContactsHelper
  def self.parse_csv_file(csv_id, csv, current_user)
    file_parsed = []
    CSV.parse(csv.file.download) do |row|
      credit_card_numer = row[4]
      detector = CreditCardValidations::Detector.new(credit_card_numer)
      row.insert(5, detector.brand_name)
      row << current_user.id
      row << csv_id
      row << Time.now
      row << Time.now
      file_parsed << row
    end

    file_parsed
  end

  def self.set_headers(params)
    [params[:header1], params[:header2], params[:header3], params[:header4], params[:header5],
     params[:header6],params[:header7],"user_id","csv_id","created_at","updated_at"]
  end

  def self.convert_file_parsed_to_string_content(file_parsed, headers)
    file_parsed = file_parsed.from(1)
    headers_str = headers.map {|str| str }.join(',')
    headers_str = headers_str + "\n"
    csv_str = file_parsed.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join("")
    content = headers_str + csv_str
  end

  def get_four_last_digits(credit_card_number)
    credit_card_number.to_s[-4..-1].to_i
  end
end
