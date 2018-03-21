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

test 'rejection' ->
    expect promise.co !->*
        yield Promise.reject 1
    .to.be.rejected-with 1

test 'rejected on throw' ->
    expect promise.co !->*
        throw 1
    .to.be.rejected-with 1

test 'yielding in catch' ->
    expect promise.co ->*
        try
            yield Promise.reject 1
        catch err
            yield 2
        3
    .to.become 3

test 'rejection on try-catch' ->
    expect promise.co !->*
        try
            throw 1
        catch err
            throw err
    .to.be.rejected-with 1

test 'rejected on rejection in catch' ->
    expect promise.co !->*
        try
            throw 1
        catch err
            yield Promise.reject err
            yield 2
    .to.be.rejected-with 1
