class Ipad::DashboardController < Ipad::BaseController
  # GET /
  # The default dashboard
  def index
    if logged_in?
      if current_user.teacher?
        @course= Course.new
        render "t_dashboard"
      elsif current_user.student?
        @sclass  = current_user.sclass
        @courses = @sclass.courses
        render "s_dashboard"
      end
    else
      render "login"
    end
  end
end
