(function(){
  window.impaq_me = {

    init: function(){
      this.button = document.createElement("button");
      this.button.textContent = "ImpaqMe";

      this.script().parentNode.insertBefore(this.button, this.script());

      // this.button.click($.proxy(this.step1, this));
    },

    script: function(){
      var scripts = document.getElementsByTagName('script');
      return scripts[scripts.length-1];
    },


    createIframe: function(){
      this.iframe = document.createElement("iframe");
      this.iframe.src = this.script().src + "/../../index.html";
      this.script().parentNode.insertBefore(this.iframe, this.script());
    }
  }


  impaq_me.init()
  impaq_me.createIframe()

})();
