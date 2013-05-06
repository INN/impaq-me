window.app.views.Meter = Backbone.View.extend({
  id: 'meter',
  template: JST['meter'],

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }
});

