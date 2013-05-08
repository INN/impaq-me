window.app.views.BannerInfo = Backbone.View.extend({
  id: 'banner_info',
  template: JST['banner_info'],

  initialize: function(options){
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
