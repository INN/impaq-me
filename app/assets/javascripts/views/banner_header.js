window.app.views.BannerHeader = Backbone.View.extend({
  template: JST['banner_header'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
