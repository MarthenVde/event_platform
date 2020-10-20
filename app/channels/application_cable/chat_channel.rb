# class ChatChannel < ApplicationCable::Channel

#   # Called when the consumer has successfully
#   # become a subscriber to this channel.
#   def subscribed
#     stream_from "chat_1"

#     #company = Company.find(params[:id])
#     company = Company.find(1)
#     stream_for company
#   end


#   def receive(data)
#     ActionCable.server.broadcast("chat_1", data)
#   end

#   # rescue_from 'MyError', with: :deliver_error_message

#   # private

#   # def deliver_error_message(e)
#   #   broadcast_to(...)
#   # end
# end


# #?????????
# # CommentsChannel.broadcast_to(@event, @company)

# # WebNotificationsChannel.broadcast_to(
# #   current_user,
# #   title: 'New things!',
# #   body: 'All the news fit to print'
# # )




