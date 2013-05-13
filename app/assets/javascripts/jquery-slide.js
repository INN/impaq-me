$.fn.slide = function(){
  var args = Array.prototype.slice.apply(arguments);
  var direction = args.pop();
  return direction ? $(this).slideDown.apply(this, args) : $(this).slideUp.apply(this, args);
};
