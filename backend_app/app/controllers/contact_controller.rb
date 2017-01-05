class ContactController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @events = Event.all
    #render text: 'lista'
  end

  def create
    ContactPersisterJob.perform_later(contact_params)

    #worker = ContactPersisterJob.new
    #worker.perform(contact_params)

    head :no_content
  end

  private

    def contact_params
      params.require(:contact).permit(:email, :uuid)
    end

end