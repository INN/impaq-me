window.app.views.WidgetHeader = Backbone.View.extend({
  template: JST['widget_header'],

  events: {
    click: "click"
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:mode': this.changeMode
    });
  },

  click: function(){
    this.model.set('open', !this.model.get('open'));
  },

  changeMode: function(model, mode, options){
    this.$el.toggle(mode === "widget");
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
