class Company < ApplicationRecord
  belongs_to :event
  has_many :ratings, as: :composite, dependent: :destroy
  has_one :zoom_config, as: :composite, dependent: :destroy
  has_rich_text :introduction
  has_rich_text :products_and_services
  has_rich_text :about_exhibitor
  has_rich_text :video_exhibitor
  has_rich_text :gallery_exhibitor
  has_rich_text :description
  has_many :videos, as: :composite, dependent: :destroy
  has_many :company_exhibitors, dependent: :destroy
  has_many :exhibitors, through: :company_exhibitors, source: :user
  has_many :page_items, as: :composite, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_one_attached :flipcard_banner, dependent: :destroy
  has_one_attached :banner, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :information_blocks, as: :composite, dependent: :destroy
  has_one :social, as: :composite, dependent: :destroy
  accepts_nested_attributes_for :information_blocks, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :exhibitors, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :page_items, allow_destroy: true
  accepts_nested_attributes_for :social, allow_destroy: true

  acts_as_taggable_on :general_tags, :styles, :languages, :countries  #You can also configure multiple tag types per model

  scope :by_title_or_description, ->(search) { where("name ILIKE ?", "%#{search}%").or(where("description_text ILIKE ?", "%#{search}%")).or(where(id: ::ActsAsTaggableOn::Taggable::TaggedWithQuery.build(Company, ActsAsTaggableOn::Tag, ActsAsTaggableOn::Tagging, ActsAsTaggableOn.default_parser.new(search).parse, {any: 
  true}).pluck(:id))) if search.present? }
  scope :by_tags, ->(general_tags) { tagged_with(general_tags, any: true, on: :general_tags) if general_tags&.any?(&:present?) }
  scope :by_languages, ->(languages) { tagged_with(languages, any: true, on: :languages) if languages&.any?(&:present?) }
  scope :by_countries, ->(countries) { tagged_with(countries, any: true, on: :countries) if countries&.any?(&:present?) }
  scope :by_styles, ->(styles) { tagged_with(styles, any: true, on: :styles) if styles&.any?(&:present?) }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  length: { maximum: 105, minimum: 6 },
  format: { with: VALID_EMAIL_REGEX } 
  validates :name, presence: true
  validates :avatar, :banner, :flipcard_banner,
    blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }

  validates :web_address, url: { allow_blank: true }
  validates :meeting_link, url: { allow_blank: true }
 

  def company_event_dropdown
    "Expo: #{event.name}, Stall: #{name} "
  end

  def next
    self.class.where("id > ?", id).where(event_id: event.id).first
  end

  def previous
    self.class.where("id < ?", id).where(event_id: event.id).last
  end

end
