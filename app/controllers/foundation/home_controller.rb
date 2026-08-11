module Foundation
  # Public marketing landing page for Beacon.
  class HomeController < ApplicationController
    def show
      @lead = Lead.new
    end
  end
end
