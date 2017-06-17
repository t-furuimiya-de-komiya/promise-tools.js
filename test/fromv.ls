require! './test.ls': {promise, expect}


suite \#fromv


test '成功時' ->
    expect promise.v.from(f, 1)
    .to.become [null, 1, 42, 111]


test '失敗時' ->
    expect promise.v.from(f, false)
    .to.become [new Error \error]


function f x, done
    if x
        done null, x, 42, 111
    else
        done new Error \error
