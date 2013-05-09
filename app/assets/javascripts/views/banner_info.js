window.app.views.BannerInfo = Backbone.View.extend({
  template: JST['banner_info'],

  events: {
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    this.$el.slideUp().promise().then(this.remove).then(app.views.banner_header.makeCloseable);
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
