window.app.views.Donate = Backbone.View.extend({
  id: 'donate',
  tagName: 'p',
  template: JST['donate'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
