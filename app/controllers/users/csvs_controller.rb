module Users
  class CsvsController < ApplicationController
    before_action :authenticate_user!

    def index
      @csvs = current_user.csvs.paginate(page: params[:page], per_page: 5)
    end
  end
end
