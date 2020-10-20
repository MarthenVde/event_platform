class SiteFilesController < ApplicationController
  def upload
    if params[:logo].present?
      @logo.attach(params[:logo]) 
      @logo.reload
    end
    if params[:banner].present?
      @banner.attach(params[:banner]) 
      @banner.reload
    end
    if params[:prospectus_document].present?
      @prospectus_document.attach(params[:prospectus_document]) 
      @prospectus_document.reload
    end
    if params[:expo_program].present?
      @expo_program.attach(params[:expo_program]) 
      @expo_program.reload
    end
    if params[:exhibit_application_form].present?
      @exhibit_application_form.attach(params[:exhibit_application_form]) 
      @exhibit_application_form.reload
    end

    render js: "window.location = '#{admin_settings_path}'"
  end
end
