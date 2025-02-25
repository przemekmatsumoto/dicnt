class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index about contact]
  before_action :resume_session
  def index
  end

  def contact
  end

  def about
  end
end
