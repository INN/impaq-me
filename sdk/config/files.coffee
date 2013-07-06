module.exports = require('lineman').config.extend 'files',
  js:
    concatenated: "generated/js/sdk.js"
    minified: "generated/js/sdk.min.js"
    dist: "../public/scripts/sdk.js"
