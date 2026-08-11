module Admin
  # Operator-facing lead review. Backed by the same madmin admin gate the
  # rest of the foundation uses; this controller only runs for admins.
  class LeadsController < ApplicationController
    include Foundation::AdminAccess

    def index
      @leads = Lead.order(created_at: :desc).limit(500)
    end
  end
end
