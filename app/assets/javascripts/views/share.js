window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
    click: "expandWidget"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  expandWidget: function(){
    app.views.widget.open();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
