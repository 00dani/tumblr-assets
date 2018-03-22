module.exports =
	devtool: 'source-map'
	externals:
		'highlight.js': 'hljs'
		jquery: 'jQuery'
	mode: 'production'
	module:
		rules: [
			{test: /\.js$/, loader: 'babel-loader', options: presets: ['env']}
			{test: /\.coffee$/, loader: 'coffee-loader'}
			{test: /\.css$/, loader: 'css-loader'}
		]
	output:
		filename: 'app.js'
	resolve:
		extensions: [
			'.web.css', '.web.coffee', '.web.js'
			'.css', '.coffee', '.js'
		]
