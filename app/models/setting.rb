class Setting < RailsSettings::Base
  # cache_prefix { "v1" }
  field :website_title, default: "Website Title Here"
  field :banner_title, default: "Banner Title Here"
  field :banner_text, default: "Banner Text Here"
  field :banner_text_short, default: "Short Banner Text Here"
  field :meta_description, default: "Google Meta Description Here"
  field :meta_keywords, default: "Google Meta keywords Here"
  field :facebook_url, default: "fabook URL Here"
  field :twitter_url, default: "Twitter URL Here "
  field :instagram_url, default: "Instagram URL Here"
  field :linkedin_url, default: "Linkedin URL here"
  field :footer_about, default: "Footer About Here"
  field :admin_email, default: "Admin Email Here"
  field :public_contact, default: "Public Contact Here"
  field :public_address, default: "Public Address Here"
  field :public_contact_more, default: "Public Contact More Here"
  field :public_email, default: "Public Email Here"
  field :logo, default: "logo", readonly: true
  field :banner, default: "banner", readonly: true
  field :google_analytics_id, default: ""

  has_one_attached :file, dependent: :destroy # used for any of the above records that require an attachment

  # field :readonly_item, type: :integer, default: 100, readonly: true
  # field :user_limits, type: :integer, default: 20
  # field :exchange_rate, type: :float, default: 0.123
  # field :admin_emails, type: :array, default: %w[admin@rubyonrails.org]
  # # Override array separator, default: /[\n,]/ split with \n or comma.
  # field :tips, type: :array, separator: /[\n]+/
  # field :captcha_enable, type: :boolean, default: 1
  # field :notification_options, type: :hash, default: {
  #   send_all: true,
  #   logging: true,
  #   sender_email: "foo@bar.com"
  # }
end