window.app.views.Share = Backbone.View.extend({
  template: JST['share'],

  events: {
    "click .email" : "emailClick"
  },

  initialize: function(options){
    _.bindAll(this);

    this.views = {
      button: new app.views.WidgetButton({model: this.model})
    };

    this.listenTo(this.model, {
      'change:mode': this.modeChanged,
      'change:open': this.openChanged
    });
  },

  modeChanged: function(model, mode, options){
    this.$el.toggle(mode === "widget");
  },

  openChanged: function(model, open, options){
    if(this.model.get('mode') !== "widget"){
      this.$el.toggle(open);
    }
  },

  emailClick: function(event){
    app.events.trigger('share:email');
  },

  render: function(){
    var data = this.model.toJSON();
    $.extend(data, {
      facebook_shortlink: location.origin + '/' + data.facebook_shortlink,
      twitter_shortlink:  location.origin + '/' + data.twitter_shortlink,
      email_shortlink:    location.origin + '/' + data.email_shortlink
    });

    this.$el.html(this.template(data));

    this.assign({
      "[data-subview='WidgetButton']" : this.views.button
    });
    return this;
  }

});
