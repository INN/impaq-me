window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:mode': this.changeMode
    });
  },

  changeMode: function(model, mode, options){
    this.$el.toggle(mode === "widget");
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
