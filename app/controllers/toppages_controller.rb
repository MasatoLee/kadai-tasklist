class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks.all.page(params[:page])
    end
  end
end
