gulp        = require 'gulp'
$             = require('gulp-load-plugins')()
webpack = require 'webpack'
buffer      = require('vinyl-buffer');
path        = require 'path'

config                = require path.join(__dirname, 'config.coffee')
webpackConfig = require path.join(__dirname, 'webpack.config.coffee')

gulp.task 'jade', ->
  gulp.src path.join(config.jadeDir, '**/*.jade')
    .pipe($.data ->
      'config': config
    )
    .pipe($.jade())
    .pipe(gulp.dest(config.distDir))

gulp.task 'image', ->
  gulp.src path.join(config.imgDir, '*.png')
    .pipe($.imagemin())
    .pipe(gulp.dest path.join(config.distDir, 'img'))

gulp.task 'sprite', ->
  spriteData = gulp.src path.join(config.spriteDir, '*.png')
    .pipe($.spritesmith(
      imgName: 'sprite.png'
      cssName: '_sprite.scss'
      imgPath: path.join(config.distDir, 'img/sprite.png')
      cssFormat: 'scss'
      cssVarMap: (sprite) ->
        sprite.name = "s-#{sprite.name}"
        return
    )
  )
  spriteData.img
    .pipe(buffer())
    .pipe($.imagemin())
    .pipe(gulp.dest path.join(config.distDir, 'img'))
  spriteData.css
    .pipe(gulp.dest config.sassDir)

gulp.task 'sass', ['sprite'], (cb) ->
  gulp.src path.join(config.sassDir, 'entry.scss')
    .pipe($.sass().on('error', $.sass.logError))
    .pipe($.autoprefixer(
      browsers: ['last 2 versions']
      cascade: false
    ))
    .pipe($.csso())
    .pipe($.rename(
      basename: 'style'
    ))
    .pipe(gulp.dest(config.distDir))

gulp.task 'js', (cb) ->
  webpack(webpackConfig, (err, stats) ->
    throw new $.util.PluginError('webpack', err) if(err)
    $.util.log('[webpack]', stats.toString())
    cb()
  )

gulp.task 'watch', ['default'], ->
  gulp.watch path.join(config.jadeDir, '**/*.jade'), ['jade']
  gulp.watch path.join(config.sassDir, '**/*.scss'), ['sass']
  gulp.watch path.join(config.jsDir, '**/*.js'), ['js']

gulp.task 'default', ['jade', 'sass', 'js', 'image']