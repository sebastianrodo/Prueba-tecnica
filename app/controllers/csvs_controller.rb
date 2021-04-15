class CsvsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_csv, only: %i[ show edit update destroy ]
  before_action :valid_csv_owner, only: %i[ show edit update destroy ]

  def show
    @file_rows = CsvsHelper.parse_csv_file(@csv).paginate(page: params[:page], per_page: 5)

    @contact = Contact.new
  end

  def new
    @csv = Csv.new
  end

  def edit
  end

  def create
    @csv = current_user.csvs.new(csv_params)

    respond_to do |format|
      if @csv.save
        format.html { redirect_to @csv, notice: "Csv was successfully created." }
        format.json { render :show, status: :created, location: @csv }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @csv.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @csv.update(csv_params)
        format.html { redirect_to @csv, notice: "Csv was successfully updated." }
        format.json { render :show, status: :ok, location: @csv }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @csv.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @csv.destroy
    respond_to do |format|
      format.html { redirect_to users_csvs_path, notice: "Csv was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_csv
    @csv = Csv.find_by(id: params[:id])
  end

  def csv_params
    params.require(:csv).permit(:file, :state)
  end
end
