
function iFrameUpdAddrBox() {

  if(this.tagName && this.tagName.toLowerCase() == 'iframe') {
    // Looks for an element immediately before the 
    // iframe with class="iframe-address-box"
    var bEl = this.previousElementSibling;
    if(bEl && bEl.classList && bEl.classList.contains('iframe-address-box')){
      var doc = this.contentWindow || this.contentDocument;
      if(doc && doc.location && doc.location.href) {
        var loc = doc.location;
        bEl.innerHTML = [
          '<span style="opacity:0.5;">',loc.host,'</span>',
          loc.pathname,loc.search,
          '<span style="color:maroon;opacity:0.6;">',loc.hash,'</span>'
        ].join('');
      }
    }
  }
}
