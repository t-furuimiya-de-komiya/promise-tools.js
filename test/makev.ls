require! './test.ls': {promise, expect}


suite \#makev


test '成功時' ->
    expect promise.makev(f, 1, 2, 3)
    .to.become [1, 2, 3]


test '失敗時' ->
    expect promise.makev(f, 3, 2, 1)
    .to.be.rejected-with Error


function f x, y, z, done
    if x < y < z
        done null, x, y, z
    else
        done new Error \error
