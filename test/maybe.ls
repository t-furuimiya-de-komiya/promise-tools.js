require! './test.ls': {promise, expect}


suite \#maybe


test '成功時' ->
    expect promise.maybe(f, 1)
    .to.become val: 1, err: null, args: [1, 42, 111]


test '失敗時' ->
    expect promise.maybe(f, false)
    .to.become args: [], val: undefined, err: new Error \error


function f x, done
    if x
        done null, x, 42, 111
    else
        done new Error \error
