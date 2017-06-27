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
        .pipe new stream.Transform {
            +object-mode
            transform: (file, _, done) ->
                delete require.cache[file.path]
                tests.add-file file.path
                done null
            flush: (done) ->
                tests.run ->
                    done null
        }

export function build
    gulp.src <[src/*.mjs]>
        .pipe new stream.Transform {
            +object-mode
            transform: (file, _, done) ->
                @push file
                rollup entry: file.path, onwarn: report -> gulplog.warn it
                .then ->
                    {code} = it.generate {-interop, format: \cjs}
                    done null, file.clone extname: \.js, contents: Buffer.from code
                .catch report -> gulplog.error it
        }
        .pipe gulp.dest '.'

function report f
    ->
        if it.frame
            f it.message
            f it.frame
        else
            f it
