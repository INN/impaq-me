(function($, _){
  window.Impaq = {
    $: $,
    _: _,
    me: {

      init: function(){
        var button = $('<button style="background:#ED1C24; color: white; width:100%; border:0; cursor:pointer;">ImpaqMe</button>')
          .on('click', $.proxy(this.createIframe, this));

        $('<div class="impaq-me-widget"></div>')
          .append(button)
          .replaceAll(".impaq-me-button");
      },

      createIframe: function(event){
        var iframe = $('<iframe src="//impaq-backend.herokuapp.com?uri='+ encodeURIComponent(location) +'"></iframe>')
          .css({
            position: 'absolute',
            top:0,
            left:0,
            border:0,
            width: '100%',
            height: '190px'
          });

        $('<div style="position:relative">')
          .append(iframe)
          .insertAfter(event.target);
      }
    }
  };


  Impaq.me.init();

})(jQuery.noConflict(true), _);//.noConflict());
