window.app.views.WidgetBody = Backbone.View.extend({
  template: JST['widget_body'],

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(options.parent, 'share', this.thanks);
  },

  thanks: function(){
    this.$("#solicit").fadeOut();
    this.$("#thanks").fadeIn();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    this.$("#thanks").hide();
    return this;
  }
});
