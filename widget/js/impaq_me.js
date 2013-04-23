(function(){
  window.impaq_me = {

    init: function(){
      this.button = document.createElement("button");
      this.button.textContent = "ImpaqMe";
      this.button.style.display = "block";

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
      this.iframe.style.border = "0";
      this.iframe.style.outline = "1px solid red";
      this.iframe.style.width = "100%";
      this.iframe.style.height = "300px";
      this.iframe.style.marginTop = ".5em";
      this.script().parentNode.insertBefore(this.iframe, this.script());
    }
  };


  impaq_me.init();
  impaq_me.createIframe();

})();
