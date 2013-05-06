window.app.views.Thanks = Backbone.View.extend({
  id: 'thanks',
  tagName: 'p',
  template: JST['thanks'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});
