window.app.views.Solicit = Backbone.View.extend({
  template: JST['solicit'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
