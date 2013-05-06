window.app.views.Feedback = Backbone.View.extend({
  id: 'feedback',
  tagName: 'p',
  template: JST['feedback'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
