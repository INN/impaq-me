window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:tweeted': this.thanks,
      'change:liked':   this.thanks,
      'change:emailed': this.thanks,
      'change:open':    this.openChanged
    });
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
