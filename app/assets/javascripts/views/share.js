window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
    click: "expandWidget"
  },

  initialize: function(options){
    _.bindAll(this);
  },

  expandWidget: function(){
    app.views.widget.open();
  },

  render: function(){
    this.$el.html(this.template(impaqme));
    return this;
  }

});

twttr.ready(function(){
  twttr.events.bind('tweet', function(event){
    app.views.widget.trigger('tweet');
  });
});

fb.ready(function(){
  FB.Event.subscribe('edge.create', function(response) {
    app.views.widget.trigger('like');
  });
});
