
function iFrameUpdAddrBox(show_parts) {

  show_parts = show_parts || ['host','pathname','search','hash','reloader'];
  
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
      
        var html = htmlForLoc(doc.location);
        if(arr_contains(show_parts,'reloader')) {
          html += ['<a ',
            'class="reloader" title="Reload the current iframe" ',
            'onclick="reloadNextiFrame.call(this)">',
          '</a>'].join('');
        }
      
        bEl.innerHTML = html;
      }
    }
  }
}

// This is designed to work with the above iFrameUpdAddrBox() for the 'reloader'
function reloadNextiFrame() {
  if(this.parentElement) {
    var nextEl = this.parentElement.nextElementSibling;
    if(nextEl.tagName && nextEl.tagName.toLowerCase() == 'iframe') {
      var doc = nextEl.contentWindow || nextEl.contentDocument;
      if(doc && doc.location && doc.location.reload) {
        var iframeDoc = nextEl.contentDocument || nextEl.contentWindow.document;
        if(iframeDoc) {
          // Just so we can see the content change
          var reloadhtml = [
            '<div style="height:',iframeDoc.body.clientHeight || 100,'px;',
            'background-color:#F0F0F0;"></div>'
          ].join('');
          iframeDoc.body.innerHTML = reloadhtml;
        }
        doc.location.reload(true);
      }
    }
  }
}