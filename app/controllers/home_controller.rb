class HomeController < ApplicationController
  def index
    if usuario_signed_in?
        redirect_to eventos_path
    end
  end
end
