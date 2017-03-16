const coroutine = require('./coroutine')

module.exports = {
    make, delay, fold, reduce, scan, forEach,
    coroutine, co: coroutine,
}

function make(f, ...args)
{
    return new Promise((resolve, reject) => {
        args.push((err, ret) => {
            if (err)
                reject(err)
            else
                resolve(ret)
        })
        f.apply(this, args)
    })
}

function delay(t)
{
    return new Promise(resolve => setTimeout(resolve, t))
}

function fold(initial, xs, f, ctx)
{
    let p = Promise.resolve(initial)
    let i = 0
    for (let x of xs)
        p = p.then(y => f.call(ctx, y, x, i++, xs))
    return p
}

function reduce(f, initial, ctx)
{
    return xs => fold(initial, xs, f, ctx)
}

function scan(xs, f, ctx)
{
    return fold(null, xs,
        ((y, x, i, xs) => f.call(ctx, x, i, xs)),
        ctx)
}

function forEach(f, ctx)
{
    return xs => scan(xs, f, ctx)
}
