Backbone.View.prototype.assign = function (selector, view) {
  var selectors;
  if (_(selector).isObject()) {
    selectors = selector;
  } else {
    selectors = {};
    selectors[selector] = view;
  }
  if (!selectors) return;
  _(selectors).each(function (view, selector) {
    view.setElement(this.$(selector)[0]).render();
  }, this);
};
