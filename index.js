const coroutine = require('./coroutine')

module.exports = {
    makev, make,
    maybe, delay,
    coroutine, co: coroutine,
}

function makev(f, ...params)
{
    return new Promise((resolve, reject) =>
        f.call(this, ...params, (err, ...args) =>
            err ? reject(err) : resolve(args)))
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

function maybe(f, ...args)
{
    return new Promise(resolve => {
        args.push((err, val) => resolve({err, val}))
        f.apply(this, args)
    })
}

function delay(t)
{
    return new Promise(resolve => setTimeout(resolve, t))
}
