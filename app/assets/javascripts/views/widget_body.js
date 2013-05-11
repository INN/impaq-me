window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:tweeted': this.thanks,
      'change:liked':   this.thanks,
      'change:open':    this.openClose
    });
  },

  openClose: function(model, open, options){
    this.$el.slideToggle(open);
  },

  thanks: function(){
    this.$("#solicit").fadeOut();
    this.$("#thanks").fadeIn();
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    this.$("#thanks").hide();
    return this;
  }
});
