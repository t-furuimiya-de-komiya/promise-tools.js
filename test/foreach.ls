require! './test.ls': {promise, expect, delay}


suite \#forEach


test 'index と context の利用' ->
    ctx = {}
    f = (x, i, xs) ->
        expect x .to.equal i
        expect this .to.equal ctx
    p = promise.for-each(f, ctx) [0 1 2 3 4 5]
    expect p .to.be.fulfilled


test '順序が正しいか' ->
    arr = []
    p = promise.for-each(delay-then-push arr) [30 10 20]
    expect p .to.be.fulfilled
    .then -> expect arr .to.eql [30 10 20]


test '比較として、Promise.all を使った場合' ->
    arr = []
    p = Promise.all [30 10 20].map delay-then-push arr
    expect p .to.be.fulfilled
    .then -> expect arr .to.eql [10 20 30]


function delay-then-push(arr)
    (x) ->
        delay x
        .then ->
            arr.push x
