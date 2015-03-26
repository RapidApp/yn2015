#!/bin/bash

# wget all the files from his online demo:

mkdir wget-slides && cd wget-slides
wget http://www.briancavalier.com/code/slides/

mkdir js && cd js
wget http://www.briancavalier.com/code/slides/js/curl.js
wget http://www.briancavalier.com/code/slides/js/wire.js
wget http://www.briancavalier.com/code/slides/js/slides-spec.js

mkdir wire && cd wire
wget http://www.briancavalier.com/code/slides/js/wire/base.js
wget http://www.briancavalier.com/code/slides/js/wire/dom.js
wget http://www.briancavalier.com/code/slides/js/wire/domReady.js

cd .. && mkdir curl && cd curl
wget http://www.briancavalier.com/code/slides/js/curl/domReady.js

mkdir plugin && cd plugin
wget http://www.briancavalier.com/code/slides/js/curl/plugin/css.js
wget http://www.briancavalier.com/code/slides/js/curl/plugin/text.js


cd ../../ && mkdir -p hc/slides && cd hc/slides
wget http://www.briancavalier.com/code/slides/js/hc/slides/SingleFilePresentationModel.js
wget http://www.briancavalier.com/code/slides/js/hc/slides/SlideView.js
wget http://www.briancavalier.com/code/slides/js/hc/slides/PresentationController.js
wget http://www.briancavalier.com/code/slides/js/hc/slides/Promise.js

cd ../../../ && mkdir css && cd css
wget http://www.briancavalier.com/code/slides/css/reset.css

mkdir themes && cd themes
wget http://www.briancavalier.com/code/slides/css/themes/fade.css
wget http://www.briancavalier.com/code/slides/css/themes/basic.css

mkdir gray && cd gray
wget http://www.briancavalier.com/code/slides/css/themes/gray/theme.css

cd ../../../ && mkdir slides && cd slides
wget http://www.briancavalier.com/code/slides/slides/slides.html

cd ..

