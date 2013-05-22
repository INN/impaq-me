window.app.services.Analytics = {
  trackPageview: function(page){
    debugger;
    ga('send', 'pageview', (page ? {page:page} : {}));
  }
};
