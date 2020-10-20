module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    #rescue_from StandardError, with: :report_error

    private
      # def find_verified_user
      #   byebug
      #   if verified_user = User.find_by(id: cookies.encrypted[:user_id])
      #     verified_user
      #   else
      #     reject_unauthorized_connection
      #   end
      # end
      def find_verified_user # this checks whether a user is authenticated with devise
        if verified_user = env['warden'].user
          verified_user
        else
          reject_unauthorized_connection
        end
      end

      def report_error(e)
        SomeExternalBugtrackingService.notify(e)
      end
    end
end
