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
      'change:mode': this.changeMode,
      'change:open': this.openClose
    });
  },

  changeMode: function(model, mode, options){
    this.$el.toggle(mode === "widget");
  },

  openClose: function(model, open_close, options){
    if(this.model.get('mode') !== "widget"){
      this.$el.slide(open_close);
    }
  },

  emailClick: function(event){
    this.model.set('emailed', true).recordEmail();
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
