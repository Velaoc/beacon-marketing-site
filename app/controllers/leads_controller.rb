class LeadsController < ApplicationController
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to root_path(anchor: "signup"), notice: "You're on the list — watch your inbox for the first signal."
    else
      redirect_to root_path(anchor: "signup"), alert: @lead.errors.full_messages.to_sentence
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :email).merge(source: "landing")
  end
end
