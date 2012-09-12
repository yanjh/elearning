class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  def index
    if logged_in?
      if current_user.teacher?
        @course= Course.new
        render "t_dashboard"
      elsif current_user.student?
        @sclass  = Sclass.find(current_user.sclass.sclass_id)
        @courses = @sclass.courses
        render "s_dashboard"
      end    
    end
  end
end
