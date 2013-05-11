window.app.views.BannerInfo = Backbone.View.extend({
  template: JST['banner_info'],

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
