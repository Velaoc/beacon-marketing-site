module Admin
  # Operator-facing lead review. The route lives outside the madmin
  # authenticated block, so this controller re-checks admin authorization
  # itself and fails closed for everyone else.
  class LeadsController < ApplicationController
    before_action :require_admin

    def index
      @leads = Lead.order(created_at: :desc).limit(500)
    end

    private

    def require_admin
      redirect_to root_path, alert: "Admins only." unless current_user&.admin?
    end
  end
end
