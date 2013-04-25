(function($, _){
  window.Impaq = {
    $: $,
    _: _,
    me: {

      init: function(){
        var button = $('<button style="background:red; color: white; width:100%">ImpaqMe</button>')
          .on('click', $.proxy(this.createIframe, this));

        $('<div class="impaq-me-widget"></div>')
          .append(button)
          .replaceAll(".impaq-me-button");
      },

      createIframe: function(event){
        var iframe = $('<iframe src="http://localhost:8003/index.html"></iframe>')
          .css({
            position: 'absolute',
            top:0,
            left:0,
            border:0,
            outline: '1px solid red',
            width: '100%',
            height: '200px'
          });

        $('<div style="position:relative">')
          .append(iframe)
          .insertAfter(event.target);
      }
    }
  };


  Impaq.me.init();

})(jQuery.noConflict(true), _);//.noConflict());
