window.app.views.BannerHeader = Backbone.View.extend({
  id: 'banner_header',
  template: JST['banner_header'],

  initialize: function(options){
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
