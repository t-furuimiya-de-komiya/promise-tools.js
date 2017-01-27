require! './test.ls': {promise, expect, delay}


suite \coroutine

const xs = [0, {}, [], ->, true, false, null, void, undefined]

function* gen x
    for i in xs
        expect i .to.eql yield i
        expect i .to.eql yield delay(1).then -> i
    x


test 'Generator' ->
    expect promise.coroutine gen!
    .to.become undefined

test 'GeneratorFunction' ->
    expect promise.coroutine ->*
        x = yield 123
        expect 123 .to.eql yield x
        1
    .to.become 1

test 'GeneratorFunction delegation' ->
    expect promise.coroutine ->* yield from gen [2]
    .to.become [2]

test 'binding GeneratorFunction' ->
    g = promise.coroutine gen
    expect g [3]
    .to.become [3]

test 'other' ->
    expect Promise.all xs.map -> promise.co it
    .to.become xs

test 'Promise' ->
    expect Promise.all xs.map (x) ->
        promise.co delay(1).then(-> x)
    .to.become xs
