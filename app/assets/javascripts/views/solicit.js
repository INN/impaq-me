window.app.views.Solicit = Backbone.View.extend({
  id: 'solicit',
  tagName: 'p',
  template: JST['solicit'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
