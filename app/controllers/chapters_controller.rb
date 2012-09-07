class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  def index
    if current_user.teacher?
      @course= Course.new
      render "t_dashboard"
    else
      
    end
    
  end
end
