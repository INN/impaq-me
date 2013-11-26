class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  MAX_SHOWN_AMOUNT = 100
  DEFAULT_WIDGET_HEADER  = '<strong>Share</strong> and {{foundation_name}} will donate <strong>${{value_per_share}}</strong>'
  DEFAULT_WIDGET_SOLICIT = '<strong>Share this article</strong> and {{foundation_name}} will donate <strong class="share-value">${{value_per_share}}</strong> to {{publisher_name}}, a non-profit news organization.'
  DEFAULT_WIDGET_CTA     = 'Show you care about public service journalism by donating an additional <strong class="donation-value">${{recommended_donation}}</strong> to {{publisher_name}}.'
  DEFAULT_WIDGET_THANKS  = '<strong>Thanks! {{publisher_name}} just got <span class= "click-value">${{value_per_share}}</span> thanks to you.</strong><br>The best way to help is to get more people involved. Tell your friends!'
  DEFAULT_BANNER_THANKS  = 'Thanks to a generous gift from {{foundation_name}},<br/>we receive <strong class="click-value">${{value_per_share}}</strong> when you or your friends <strong>share this story</strong>.'
  DEFAULT_EMAIL_BODY     = 'I thought you would like this article:

{{article_title}} - {{email_shortlink}}

Each time this article is shared, {{foundation_name}} donates ${{value_per_share}} to {{publisher_name}}. So far, they have donated ${{total}}.
Learn more at http://impaq.me'

  field :recommended_donation , type: Float  , default: 1.0
  field :widget_header        , type: String , default: DEFAULT_WIDGET_HEADER
  field :widget_solicit       , type: String , default: DEFAULT_WIDGET_SOLICIT
  field :widget_follow_up_cta , type: String , default: DEFAULT_WIDGET_CTA
  field :widget_thanks        , type: String , default: DEFAULT_WIDGET_THANKS
  field :banner_thanks        , type: String , default: DEFAULT_BANNER_THANKS
  field :email_body           , type: String , default: DEFAULT_EMAIL_BODY
  field :css_overrides        , type: String , default: ''
  field :shown_amount         , type: Float  , default: 100.0

  belongs_to :campaign

  default_scope asc(:created_at)
end
