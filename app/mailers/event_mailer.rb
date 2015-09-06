class EventMailer < ApplicationMailer
  def eventNotification(user,event)
    @user = user
    @event = event
    if Event.where(id: event.id).exists? and (@event.start_datetime - Time.now).to_i.abs / 216000 <= 15
      mail(to: @user.email, subject: "Скоро начнется #{@event.title}")
    end
  end
end
