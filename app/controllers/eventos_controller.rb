class EventosController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_usuario!
  before_action :set_evento, only: [:show, :edit, :update, :destroy]


  SLEEP_BEFORE_CHECKING_BG_STATUS = 1
  include Sidekiq::Worker
  include Sidekiq::Status::Worker


  def index
    @eventos = Evento.all
  end


  def show
  end


  def new
    @evento = Evento.new
  end


  def edit
  end


  def create

    @usuario = current_usuario
    @evento = @usuario.eventos.new(evento_params)

    respond_to do |format|
      if @evento.save
        # page_wall_post

        PostmanWorker.perform_async(@evento.titulo, @evento.contenido)

        format.html { redirect_to @evento, notice: 'Evento creado y enviado correctamente.' }
        format.json { render :show, status: :created, location: @evento }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @evento.update(evento_params)

      else
        format.html { render :edit }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventos/1
  # DELETE /eventos/1.json
  def destroy
    @evento.destroy
    respond_to do |format|
      format.html { redirect_to eventos_url, notice: 'Evento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def page_wall_post

    @access_token = 'EAAJvD0ZARECwBAKJt3VTH9Lf4xlcRcP1dDuRSjkSxLuVKt7R9TIuG0Xf7QDhJRQWSye3zOi3oaYPSDjeGIMWGPwot0AhH2RKQqFnK56wooGz7XolX8W6zbXYJQ5OUm4Vdo14KqC9BJXtAoPL1GLNpfZCwYejQZD'

    @graph = user = Koala::Facebook::API.new(@access_token)

    page_token = user.get_page_access_token(500800109948586)

    @page = Koala::Facebook::API.new(page_token)

    @access_token = params[:access_token].present? ? params[:access_token] : @access_token
    title = @evento.titulo
    page_link = 'https://www.facebook.com/pg/benjamin0mar'
    link_name = 'RailsApp'
    description =  @evento.contenido
    image_url = 'https://www.facebook.com/cgsociety/photos/a.10150236256400109.461531.16448385108/10158001712035109/?type=3'
    success_msg = 'Evento Posted'

    begin
      post_info = @page.put_wall_post(title, {
          name: link_name, description: description, picture: image_url, link: page_link
      })
    rescue Exception => e
      success_msg = e.message
    end

  end




  private

    def set_evento
      @evento = Evento.find(params[:id])
    end


    def evento_params
      params.require(:evento).permit(:titulo, :contenido, :usuario_id)
    end

end
