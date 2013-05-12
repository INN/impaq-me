window.app.views.BannerHeader = Backbone.View.extend({
  template: JST['banner_header'],

  events: {
    // click: "openWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});
