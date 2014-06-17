module Sql
  class Variant < ActiveRecord::Base
    MAX_SHOWN_AMOUNT = 100

    default_scope { order(:created_at) }

    belongs_to :campaign

    def widget_header
      super || DEFAULT_WIDGET_HEADER
    end

    def widget_solicit
      super || DEFAULT_WIDGET_SOLICIT
    end

    def widget_follow_up_cta
      super || DEFAULT_WIDGET_CTA
    end

    def widget_thanks
      super || DEFAULT_WIDGET_THANKS
    end

    def banner_thanks
      super || DEFAULT_BANNER_THANKS
    end

    def email_body
      super || DEFAULT_EMAIL_BODY
    end

    DEFAULT_WIDGET_HEADER  = '<strong>Share</strong> and {{foundation_name}} will donate <strong>${{value_per_share}}</strong>'
    DEFAULT_WIDGET_SOLICIT = '<strong>Share this article</strong> and {{foundation_name}} will donate <strong class="share-value">${{value_per_share}}</strong> to {{publisher_name}}, a non-profit news organization.'
    DEFAULT_WIDGET_CTA     = 'Show you care about public service journalism by donating an additional <strong class="donation-value">${{recommended_donation}}</strong> to {{publisher_name}}.'
    DEFAULT_WIDGET_THANKS  = '<strong>Thanks! {{publisher_name}} just got <span class= "click-value">${{value_per_share}}</span> thanks to you.</strong><br>The best way to help is to get more people involved. Tell your friends!'
    DEFAULT_BANNER_THANKS  = 'Thanks to a generous gift from {{foundation_name}},<br/>we receive <strong class="click-value">${{value_per_share}}</strong> when you or your friends <strong>share this story</strong>.'
    DEFAULT_EMAIL_BODY     = 'I thought you would like this article:

  {{article_title}} - {{email_shortlink}}

  Each time this article is shared, {{foundation_name}} donates ${{value_per_share}} to {{publisher_name}}. So far, they have donated ${{total}}.
  Learn more at http://impaq.me'
  end
end
