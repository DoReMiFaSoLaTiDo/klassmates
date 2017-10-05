class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  pages = [:index, :about]

  # pages.each do |page|
  #   define_method #{page} {}
  # end

  def index
  end

  def about
  end

end
