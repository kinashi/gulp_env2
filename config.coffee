path = require 'path'

module.exports = {
  srcDir    : path.join(__dirname, 'app')
  distDir   : path.join(__dirname, 'public')

  jsDir      : path.join(__dirname, 'app/assets/javascripts')
  sassDir : path.join(__dirname, 'app/assets/stylesheets')
  imgDir   : path.join(__dirname, 'app/assets/images/')
  spriteDir: path.join(__dirname, 'app/assets/images/sprite')
  jadeDir  : path.join(__dirname, 'app/views/')

  jsOutputName: 'bundle.js'
  cssOutputName: 'style.css'
}