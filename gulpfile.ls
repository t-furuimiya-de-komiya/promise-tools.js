process.on \unhandledRejection ->
    console.error it

require! {gulp, gulplog, mocha, stream}
require! rollup: {rollup}

gulp.task \default, gulp.series build, test
gulp.task \watch, gulp.series \default, watch

function watch
    gulp.watch <[src test]>, gulp.task \default

export function test
    tests = new mocha {ui: \qunit}
    gulp.src <[test/*.ls]>, {-read}
        .pipe new stream.Writable {
            +object-mode
            write: (file, _, done) ->
                delete require.cache[file.path]
                tests.add-file file.path
                done null
            final: (done) ->
                tests.run ->
                    done null
        }

export function build
    gulp.src <[src/*.mjs]>
        .pipe new stream.Transform {
            +object-mode
            transform: (mjs, _, done) ->
                rollup input: mjs.path, onwarn: report -> gulplog.warn mjs.relative, it
                .then -> it.generate {-interop, format: \cjs}
                .then ~>
                    @push mjs
                    js = mjs.clone {-contents}
                    js.extname = \.js
                    js.contents = Buffer.from it.code
                    @push js
                .catch report -> gulplog.error mjs.relative, it
                .then -> done null
        }
        .pipe gulp.dest '.'

function report f
    ->
        if it.frame
            f it.message
            f it.frame
        else
            f it
