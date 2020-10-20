module Admin
    class SettingsController < ApplicationController
      before_action :get_setting, only: [:edit, :update]
  
      def index
        authorize Setting
      end

      def create
        authorize Setting
        setting_params.keys.each do |key|
          Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
        end
        redirect_to admin_settings_path, notice: "Setting was successfully updated."
      end
  
      private
        def setting_params
          params.require(:setting).permit(:google_analytics_id, :website_title, :banner_title, :banner_text, :banner_text_short, :meta_description, :facebook_url, :twitter_url, :instagram_url,
            :linkedin_url, :footer_about, :meta_keywords, :admin_email, :admin_contact, :public_contact_more, :public_email, :public_contact, :public_address)
        end
    end
  end