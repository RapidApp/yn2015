
// shortcut for common invocation:
function iFrameAboxRel() {
  return iFrameUpdAddrBox.call(
    this, ['path','reloader'],
    {relpath:'/fs/files/approot'}
  );
}

function iFrameUpdAddrBox(show_parts,opts,hashchange) {

  if(!this.tagName || this.tagName.toLowerCase() != 'iframe') {
    return;
  }
  
  // setup event listener/handler for the hash change event, since it does 
  // not trigger 'onload' (which is probably how we were called originally)
  if(!hashchange) {
    var ifrm = this;
    var window = ifrm.contentWindow;
    var orig_listener = window.onhashchange || function(){};
    window.onhashchange = function(){
      orig_listener.apply(this,arguments);
      iFrameUpdAddrBox.call(ifrm,show_parts,opts,true);
    }
  }
  
  
  // This is common filler content we'll use in several places
  if(!this.applyReloadContent) {
    var iframe = this;
    this.applyReloadContent = function(inner) {
      var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
      inner = inner || '';
      var html = [
        '<body style="margin:0px;">',
          '<div style="height:',(iframeDoc.body.clientHeight || 100)-2,'px;',
          'background-color:#F8F8F8;border: 1px solid #d0d0d0;',
          'color:#d0d0d0;font-family:sans-serif;',
        '"><div style="margin:8px;">',inner,'</div></div></body>'
      ].join('');
      iframeDoc.body.outerHTML = html;
    }
  }
  
  opts = opts || {};
  show_parts = show_parts || [
    'host','pathname','search','hash',
    'link','reloader'
  ];
  
  var arr_contains = function(a, obj) {
    for (var i = 0; i < a.length; i++) {
      if(a[i] == 'path') { a[i] = 'pathname'; } // treat 'path' as an alias for 'pathname'
      if (a[i] === obj) { return true; }
    }
    return false;
  };
  
  var htmlForLoc = function(loc) {
    var tags = [], ndx, props = ['protocol','host','pathname','search','hash'];
    for (ndx = 0; ndx < props.length; ++ndx) {
      var key = props[ndx], val = loc[key];
      if(arr_contains(show_parts,key)) {
        if(key == 'protocol') { 
          val = val+'//'; 
        }
        else if(key == 'pathname' && opts.relpath) {
          var pth = opts.relpath;
          // Allow leading/trailimg slashes to be implied
          if(pth.slice(0,1)  != '/') { pth = '/'+pth; }
          if(pth.slice(-1) != '/') { pth += '/'; }
          var parts = val.split(pth);
          if(parts.length == 2 && parts[0] == '') {
            val = ' ' + parts[1];
          }
        }
        tags.push([
          '<span class="',key,'">',val,'</span>'
        ].join(''));
      }
    }
    return tags.join('');
  };

  // Looks for an element immediately before the 
  // iframe with class="iframe-address-box"
  var bEl = this.previousElementSibling;
  if(bEl && bEl.classList && bEl.classList.contains('iframe-address-box')){
    var doc = this.contentWindow || this.contentDocument;
    if(doc && doc.location && doc.location.href) {
    
      var html = htmlForLoc(doc.location);
      
      if(arr_contains(show_parts,'link')) {
        html = ['<a ',
          'class="link" target="_blank" ',
          'title="Open URL in a new window" ',
          'href="',doc.location.href,'"',
          '>',html,'</a>'
        ].join('');
      }
      
      if(arr_contains(show_parts,'reloader')) {
        html += ['<a ',
          'class="reloader" title="Reload the current iframe" ',
          'onclick="reloadNextiFrame.call(this)">',
        '</a>'].join('');
      }
      
      if(bEl.style.visibility == 'hidden' && doc.location.href != 'about:blank') {
        bEl.style.visibility = 'visible';
      }
      
      if(doc.location.href == 'about:blank' && bEl.style.visibility != 'hidden') {
        this.applyReloadContent();
      }
      
      bEl.innerHTML = html;
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
        // Just so we can see the content change
        if(nextEl.applyReloadContent) {
          nextEl.applyReloadContent([
            '<h1>Reloading...</h1>'
          ].join(''));
        }
        doc.location.reload(true);
      }
    }
  }
}