
module.exports = {make, from, maybe, maybep, delay}


function make(f, ...args)
{
    return new Promise((resolve, reject) =>
        f.call(this, ...args, (err, ret) =>
            err ? reject(err) : resolve(ret)))
}

function from(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, resolve))
}

function maybe(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, (err, val) =>
            resolve({err, val})))
}

function maybep(p)
{
    return p.then((val => ({val})), (err => ({err})))
}

function delay(t)
{
    return new Promise(resolve => setTimeout(resolve, t))
}
