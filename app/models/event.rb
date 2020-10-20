class Event < ApplicationRecord
    has_rich_text :about
    has_rich_text :terms_and_conditions
    has_rich_text :faq
    has_rich_text :faq_exhibitor
    has_rich_text :apply_faq_exhibitor
    has_rich_text :home_page_data
    has_rich_text :introduction
    has_rich_text :apply_to_exhibit
    has_rich_text :who_should_attend
    has_rich_text :info_desk
    has_many :event_attendees, dependent: :destroy
    has_many :videos, as: :composite, dependent: :destroy
    has_many :sponsors, dependent: :destroy
    has_many :attendees, through: :event_attendees, source: :user
    has_many :companies, dependent: :destroy
    has_many :company_exhibitors, through: :companies
    has_many :exhibitors, through: :companies
    has_one_attached :avatar, dependent: :destroy
    has_one_attached :banner, dependent: :destroy
    has_one_attached :workshop_image, dependent: :destroy
    has_one_attached :presentation_image, dependent: :destroy
    has_one_attached :exhibitor_image, dependent: :destroy
    has_one_attached :who_should_attend_image, dependent: :destroy
    has_one_attached :image, dependent: :destroy
    has_one_attached :prospectus_document, dependent: :destroy
    has_one_attached :expo_program, dependent: :destroy
    has_one_attached :pdf_program, dependent: :destroy
    has_one_attached :exhibit_application_form, dependent: :destroy
    has_many :attachments, as: :attachable, dependent: :destroy
    has_many :advertisements, as: :composite, dependent: :destroy
    has_many :user_description_selects, as: :composite, dependent: :destroy
    has_many :page_items, as: :composite, dependent: :destroy
    has_many :event_admins, dependent: :destroy
    has_many :admins, through: :event_admins, source: :user
    has_one  :social, as: :composite, dependent: :destroy
    has_one  :mail_setting, as: :composite, dependent: :destroy
    has_many :presentations, dependent: :destroy
    has_many :workshops, dependent: :destroy
    has_many :workshop_presenters
    has_many :information_blocks
    has_one :zoom_config
    accepts_nested_attributes_for :advertisements, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :companies, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :presentations, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :workshop_presenters, allow_destroy: true
    accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :page_items, allow_destroy: true
    accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :user_description_selects, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :sponsors, allow_destroy: true
    accepts_nested_attributes_for :social, allow_destroy: true
    accepts_nested_attributes_for :mail_setting, allow_destroy: true
    accepts_nested_attributes_for :presentations, allow_destroy: true
    accepts_nested_attributes_for :workshops, allow_destroy: true

    validates_associated :mail_setting
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
    length: { maximum: 105, minimum: 6 },
    format: { with: VALID_EMAIL_REGEX }   

    validates :avatar, :banner, :who_should_attend_image, :exhibitor_image, :presentation_image, :workshop_image, presence: true, 
    presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }

    def event_dropdown
        "Expo: #{name}"
    end
end
