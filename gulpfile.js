var gulp = require('gulp'),
    sass = require('gulp-sass'),
    coffee = require('gulp-coffee'),
    clean = require('gulp-clean'),
    gutil = require('gulp-util'),
    notify = require('gulp-notify'),
    rev = require('gulp-rev'),
    fs = require('fs');

var basePath = './source',
    buildPath = './www',
    sassPath = basePath + '/styles',
    sassBuildPath = buildPath + '/styles',
    coffeePath = basePath + '/scripts',
    coffeeBuildPath = buildPath + '/scripts',
    partialPath = basePath + '/partials',
    partialBuildPath = buildPath + '/partials',
    imagePath = basePath + '/images',
    imageBuildPath = buildPath + '/images',
    fontSource = basePath + '/fonts',
    fontBuildPath = buildPath + '/fonts',
    libPath = basePath + '/lib/',
    libBuildPath = buildPath + '/lib';

var sassSource = [sassPath + '/*.scss', sassPath + '/*/*.scss'],
    coffeeSource = [coffeePath + '/*.coffee', coffeePath + '/*/*.coffee', coffeePath + '/*/*/*.coffee'],
    partialSource = [partialPath + '/*.html', partialPath + '/*/*.html'],
    imageSource = [imagePath + '/*', imagePath + '/*/*', imagePath + '/*/*/*'],
    indexSource = [basePath + '/*.html'];

/**
 * Convert scss file to css
 */
gulp.task('sass', function () {
  gulp.src(sassPath + '/app.scss')
    .pipe(sass().on('error', gutil.log))
    .pipe(gulp.dest(sassBuildPath));
});

/**
 * Convert coffee file to javascipt
 */
gulp.task('coffee', function() {
  gulp.src(coffeeSource)
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest(coffeeBuildPath));
});

/**
 * Copy image and html file to build folder
 */
gulp.task('copy', function() {
  return gulp.start('copyLib', 'copyFonts', 'copyPartial', 'copyImage', 'copyIndex');
});

/**
 * Copy html file to build folder
 */
gulp.task('copyPartial', function() {
  return gulp.src(partialSource)
    .pipe(gulp.dest(partialBuildPath));
});

/**
 * Copy image file to build folder
 */
gulp.task('copyImage', function() {
  return gulp.src(imageSource)
    .pipe(gulp.dest(imageBuildPath));
});

/**
 * Copy index file to build folder
 */
gulp.task('copyIndex', function() {
  return gulp.src(indexSource)
    .pipe(gulp.dest(buildPath));
});

function endWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

/**
 * Copy script lib file to build folder
 */
gulp.task('copyLib', function() {
  return fs.readFile(basePath + '/config.json', 'utf8', function (err, data) {
      if (err) throw err; // we'll not consider error handling for now
      var obj = JSON.parse(data),
        libSource = [];
      var items = obj.lib;
      for (var i = 0; i < items.length; i++) {
        if (endWith(items[i], '.min.js')) {
          libSource.push(libPath + items[i] + '.map');
        }
        libSource.push(libPath + items[i]);
      }
      return gulp.src(libSource)
        .pipe(gulp.dest(libBuildPath));
  });
});

/**
 * Copy script lib file to build folder
 */
gulp.task('copyFonts', function() {
  return fs.readFile(basePath + '/config.json', 'utf8', function (err, data) {
      if (err) throw err; // we'll not consider error handling for now
      var obj = JSON.parse(data),
        fontSource = [];
      var items = obj.fonts;
      for (var i = 0; i < items.length; i++) {
        fontSource.push(libPath + items[i]);
      }
      return gulp.src(fontSource)
        .pipe(gulp.dest(fontBuildPath));
  });
});

/**
 * Clean build folder
 */
gulp.task('clean', function() {
  return gulp.src(buildPath, {read: false})
    .pipe(clean())
    .pipe(notify({message: 'clean task complete'}));
});

gulp.task('default', ['clean'], function() {
  return gulp.start('copy', 'sass', 'coffee');
});

/**
 * Watch sass/coffee/i18n/html/image file
 */
gulp.task('watch', function() {
  gulp.watch(sassSource, ['sass']);
  gulp.watch(coffeeSource, ['coffee']);
  gulp.watch(partialSource, ['copyPartial']);
  gulp.watch(imageSource, ['copyImage']);
  gulp.watch(indexSource, ['copyIndex']);
  gulp.watch([libPath + '*', buildPath + '/config.json'], ['copyLib']);
});
