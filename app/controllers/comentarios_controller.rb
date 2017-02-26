  class ComentariosController < ApplicationController
    def create
      @evento = Evento.find(params[:evento_id])
      @comentario = @evento.comentarios.create(comentarios_params)
      ComentarioMailer.comentario_mail(@evento,current_usuario,@comentario).deliver_now
      redirect_to post_path(@evento)
    end

    private

    def comentarios_params
        params.require(:comentario).permit(:contenido)
    end
  end
