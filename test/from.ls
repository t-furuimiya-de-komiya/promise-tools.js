require! './test.ls': {promise, expect}


suite \#from


test '成功時' ->
    expect promise.from(f, 1)
    .to.become null


test '失敗時' ->
    expect promise.from(f, false)
    .to.become new Error \error


function f x, done
    if x
        done null, x, 42, 111
    else
        done new Error \error
