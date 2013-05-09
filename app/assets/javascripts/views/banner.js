window.app.views.Banner = Backbone.View.extend({
  template: JST['banner'],

  events: {
    "click button": "close",
    click: "expandWidget" //TODO handle repeat clicks
  },

  initialize: function(options){
    _.bindAll(this);
  },

  close: function(){
    console.log("nuclear");
    //TODO tell parent window to remove iframe
  },

  minimize: function(){
    this.$('.thanks').slideUp();
  },

  expandWidget: function(){
    $("#widget").empty().hide()
      .append(app.views.share.el)
      .append(app.views.solicit.el)
      .append(app.views.donate.el)
      .append(app.views.footer.el)
      .slideDown();
      //TODO: reparse FB/Twitter widgets
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});
