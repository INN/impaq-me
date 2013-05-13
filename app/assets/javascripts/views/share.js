window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);

    this.listenTo(this.model, {
      'change:mode': this.changeMode,
      'change:open': this.openClose
    });
  },

  changeMode: function(model, mode, options){
    this.$el.toggle(mode === "widget");
  },

  openClose: function(model, open_close, options){
    if(this.model.get('mode') !== "widget"){
      this.$el.slide(open_close);
    }
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
