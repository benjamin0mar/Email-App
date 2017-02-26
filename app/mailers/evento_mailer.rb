class EventoMailer < ActionMailer::Base

  include SendGrid
  # def evento_mail(usuario,evento)
  #   @usuario = usuario
  #   @evento = evento
  #   mail(to: usuario.email,
  #       from: "services@gmail.com" ,
  #       subject: "Evento Creado" ,
  #       )
  # end

  default from: 'services@omarbenjamin.com'
  #
  # def self.send_evento(evento)
  #   persons = Usuario.pluck(:email)
  #   # persons = ['benjaminomar34@gmail.com']
  #
  #   persons.each do |person|
  #     evento_mail(person,evento)
  #   end
  #
  # end
  #
  # def evento_mail(person, evento)
  #   @evento = evento
  #   @email = person
  #   mail(to: person , subject: 'Nuevo Evento')
  # end
  #

  # default to: Usuario.pluck(:email),
  #         from: 'services@omarbenjamin.com'

   def evento_mail(email, titulo , contenido)
     @contenido = contenido
     @titulo = titulo
     @email = email
     mail(to: email , subject: 'Nuevo Evento')
   end

end
