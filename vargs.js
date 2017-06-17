
module.exports = {make, from, maybe}

function make(f, ...params)
{
    return new Promise((resolve, reject) =>
        f.call(this, ...params, (err, ...args) =>
            err ? reject(err) : resolve(args)))
}

function from(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, (...args) => resolve(args)))
}

function maybe(f, ...params)
{
    return from.call(this, f, ...params)
    .then(([err, ...args]) => ({err, args, val: args[0]}))
}
