module Csvs
  class ContactsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_csv, only: [:create]
    before_action :set_csv_processeing_state, only: [:create]
    after_action :change_csv_state, only: [:create]
    before_action :valid_contact_owner, only: %i[ index ]

    def index
      @contacts = current_user.contacts.paginate(page: params[:page], per_page: 5)
    end

    def create
      headers = ContactsHelper.set_headers(params)
      @file_parsed = ContactsHelper.parse_csv_file(params[:csv_id], @csv, current_user)
      content = ContactsHelper.convert_file_parsed_to_string_content(@file_parsed, headers)

      @import = ImportContactCsv.new(content: content)
      @import.run!

      @errors = get_errors(@import)

      respond_to do |format|
        format.html { redirect_to csv_contacts_path(csv_id: params[:csv_id]),
          notice: @import.report.message,
          alert: @errors
        }
      end
    end

    private

    def set_csv
      @csv = Csv.find(params[:csv_id])
    end

    def set_csv_processeing_state
      @csv.process!
    end

    def change_csv_state
      @csv.hold_on! if @file_parsed.empty?
      @csv.fail! if @import.report.invalid_rows.count == @file_parsed.count
      @csv.finish! if @import.report.created_rows.count > 0
    end

    def get_errors(import)
      import.report.invalid_rows.map { |row| [row.line_number, row.model.email, row.errors] }
    end
  end
end
