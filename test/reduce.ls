require! './test.ls': {promise, expect, delay}
require! '../seq': promise


suite \#reduce


test '基本的な例' ->
    ctx = {}
    f = (a, x) ->
        expect this .to.equal ctx
        a + x
    expect promise.reduce(f, 1, ctx)([2 4 8])
    .to.become 15


test '引数が iterator の場合' ->
    gen = ->*
        yield 8
        yield 4
        yield 2
    expect promise.reduce((+), 1)(gen!)
    .to.become 15


test 'callback が Promise を返す場合' ->
    f = (a, x) ->
        Promise.resolve a + x
    p = promise.reduce(f, 1) [2 4 8]
    expect p .to.become 15


test '順序が正しいか' ->
    f = (a, x) ->
        delay x
        .then ->
            a.push x
            a
    p = promise.reduce(f, [0]) [30 10 20]
    expect p .to.become [0 30 10 20]
