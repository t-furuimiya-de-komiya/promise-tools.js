require! './test.ls': {promise, expect}


suite \#make


test '成功時' ->
    expect promise.make(f, 1)
    .to.become 1


test '失敗時' ->
    expect promise.make(f, false)
    .to.be.rejected-with Error


function f x, done
    if x
        done null, x
    else
        done new Error \error
