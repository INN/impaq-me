window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  events: {
    'submit form.paypal': 'paypalDonation'
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:open':    this.openChanged
    });

    this.listenTo(app.events, {
      'share:twitter':  this.thanks,
      'share:facebook': this.thanks,
      'share:email':    this.thanks
    });
  },

  paypalDonation: function(){
    app.services.Analytics.trackEvent('followup_cta', 'click', 'paypal_donate');
  },

  openChanged: function(model, open_close, options){
    this.$el.toggle(open_close);
  },

  thanks: function(){
    this.$(".solicit").fadeOut().promise()
      .then($.proxy(function(){ this.$(".thanks").fadeIn(); }, this));
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    this.$(".thanks").hide();
    return this;
  }
});
