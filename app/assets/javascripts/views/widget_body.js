window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

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
