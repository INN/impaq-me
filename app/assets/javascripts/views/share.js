window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  initialize: function(options){
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
