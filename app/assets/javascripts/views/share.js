window.app.views.Share = Backbone.View.extend({
  id: 'share',
  template: JST['share'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
