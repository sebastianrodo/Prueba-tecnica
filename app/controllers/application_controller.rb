class ApplicationController < ActionController::Base
  def valid_csv_owner
    if @csv.nil?
      message = 'It csv file does not exists'

      respond_to do |format|
        format.html do
          redirect_to users_contacts_url,
                      alert: message
        end
      end

      return false

    else
      return true if belongs_to_current_user(@csv.user_id)

      message = 'You cannot do this action, you are not the owner of this csv file.'

      respond_to do |format|
        format.html do
          redirect_to users_csvs_url,
                      alert: message
        end
      end
      false
    end
  end

  def valid_contact_owner
    @csv = Csv.find_by(id: params[:csv_id])

    return true if belongs_to_current_user(@csv.user_id)

    message = 'You cannot do this action, you are not the owner of these contacts.'

    respond_to do |format|
      format.html do
        redirect_to users_contacts_url,
                    alert: message
      end
    end
    false
  end

  private

  def belongs_to_current_user(id)
    id == current_user.id
  end
end
