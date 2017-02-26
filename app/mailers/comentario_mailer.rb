class ComentarioMailer < ActionMailer::Base

  def comentario_mail(evento,usuario,comentario )
  @evento = evento
  @usuario = usuario
  @comentario = comentario
    mail(to: usuario.email,
        from: "services@gmail.com" ,
        subject: "Comento Tu Evento" ,
        )
  end
end
