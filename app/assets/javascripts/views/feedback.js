window.app.views.Feedback = Backbone.View.extend({
  id: 'feedback',
  template: JST['feedback'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
