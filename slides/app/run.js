/* @license Copyright (c) 2011-2013 Brian Cavalier */
(function(curl) {

	curl({
		main: 'app/main',
		paths: {
			'themes': 'css/themes',
			'markdown': 'app/hc/markdown'
		},
		packages: {
			curl: { location: 'pkg/curl' },
			when: { location: 'pkg/when', main: 'when' },
			marked: { location: 'pkg/marked', main: 'lib/marked' },
			highlightjs: { location: 'pkg/highlightjs', main: 'highlight.pack.js' }
		}
	});

})(window.curl);