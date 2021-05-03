class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end
  def unsubscribed
  end
  def speak(data)
    message = Message,create!(content: data["message"])
    ActionCable.server.broadcast(
      "room_channel", { message: data["message"] }
    )
  end

  private

  def render_message(message)
    ApplicationController.render(
      pratial: "message/message",
      locals: { message: message }
    )
  end
end
