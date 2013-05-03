window.app.views.Meter = Backbone.View.extend({
  id: 'meter',
  tagName: 'p',
  template: JST['meter'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});

