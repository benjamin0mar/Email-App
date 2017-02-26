class PostmanWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(titulo , contenido)
      emails = Usuario.pluck(:email)
      emails.each do |email|
        EventoMailer.delay.evento_mail(email, titulo , contenido)
      end
  end
end
