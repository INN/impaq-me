window.app.views.WidgetFooter = Backbone.View.extend({
  template: JST['widget_footer'],

  events: {
    'click .about-funding': 'aboutFundingClicked',
    'click .about-impaqme': 'aboutImpaqmeClicked'
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:open': this.openChanged
    });
  },

  openChanged: function(model, open_close, options){
    this.$el.toggle(open_close);
  },

  aboutFundingClicked: function(){
    app.services.Analytics.trackEvent('footer', 'click', 'about_funding');
  },

  aboutImpaqmeClicked: function(){
    app.services.Analytics.trackEvent('footer', 'click', 'about_impaqme');
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }
});
