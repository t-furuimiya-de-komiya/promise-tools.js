require! './test.ls': {promise, expect}


suite \#maybep


test '成功時' ->
    expect promise.maybep(promise.make f, 1)
    .to.become val: 1


test '失敗時' ->
    expect promise.maybep(promise.make f, false)
    .to.become err: new Error \error


function f x, done
    if x
        done null, x
    else
        done new Error \error
