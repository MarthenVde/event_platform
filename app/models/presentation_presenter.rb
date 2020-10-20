class PresentationPresenter < ApplicationRecord
  belongs_to :company_exhibitor
  belongs_to :presentation
  validates :presentation, uniqueness: { scope: :company_exhibitor, message: 'Presenter already added to presentation' }
  def presentation_presenter_name
    company_exhibitor.user.name
  end

end
