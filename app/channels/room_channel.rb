class RoomChannel < ApplicationCable::Channel
  # 監視する
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # frontからのデータを受け取って、DBに格納する
    message = Message.create!(content: data['message'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    #  frontにbroadcastする。送信先は,room.jsのRoomChannel
    ActionCable.server.broadcast 'room_channel',template 
    # binding.pry
  end
end
