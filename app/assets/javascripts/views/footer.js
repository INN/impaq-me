window.app.views.Footer = Backbone.View.extend({
  tagName: 'footer',
  template: JST['footer'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
