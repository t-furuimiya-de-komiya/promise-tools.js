const coroutine = require('./coroutine')

module.exports = {
    makev, make,
    maybep,
    maybe,
    delay,
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
    return makev.call(this, f, ...args).then(val => val[0])
}

function maybep(p)
{
    return p.then((val => ({val})), (err => ({err})))
}

function maybe(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, (err, ...args) =>
            resolve({err, args, val: args[0]})))
}

function delay(t)
{
    return new Promise(resolve => setTimeout(resolve, t))
}
