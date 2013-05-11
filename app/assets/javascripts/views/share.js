window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
