
function iFrameUpdAddrBox(show_parts) {

  show_parts = show_parts || ['host','pathname','search','hash'];
  
  var arr_contains = function(a, obj) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] === obj) { return true; }
    }
    return false;
  };
  
  var htmlForLoc = function(loc) {
    var tags = [], ndx, props = ['protocol','host','pathname','search','hash'];
    for (ndx = 0; ndx < props.length; ++ndx) {
      var key = props[ndx], val = loc[key];
      if(arr_contains(show_parts,key)) {
        if(key == 'protocol') { val = val+'//'; }
        tags.push([
          '<span class="',key,'">',val,'</span>'
        ].join(''));
      }
    }
    return tags.join('');
  };

  if(this.tagName && this.tagName.toLowerCase() == 'iframe') {
    // Looks for an element immediately before the 
    // iframe with class="iframe-address-box"
    var bEl = this.previousElementSibling;
    if(bEl && bEl.classList && bEl.classList.contains('iframe-address-box')){
      var doc = this.contentWindow || this.contentDocument;
      if(doc && doc.location && doc.location.href) {
        bEl.innerHTML = htmlForLoc(doc.location);
      }
    }
  }
}
