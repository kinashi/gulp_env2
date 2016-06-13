path = require 'path'
webpack = require 'webpack'
BowerWebpackPlugin = require 'bower-webpack-plugin'

config = require path.join(__dirname, 'config.coffee')

module.exports = {
  entry: path.join(config.jsDir, 'entry.js')
  output:
    path: './public'
    filename: 'bundle.js'
  resolve:
    modulesDirectories: ['node_modules']
    extensions: ['', '.js']
  plugins: [
    new webpack.optimize.DedupePlugin()
    new webpack.optimize.UglifyJsPlugin(
      compress:
        warnings: false
    )
    new BowerWebpackPlugin(
      modulesDirectories: ['bower_components'],
      manifestFiles: 'bower.json',
      includes: /.js/,
      excludes: [],
      searchResolveModulesDirectories: true
    )
    # new webpack.ProvidePlugin(
    # )
  ]
}
