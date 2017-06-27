
export function make(f, ...params)
{
    return new Promise((resolve, reject) =>
        f.call(this, ...params, (err, ...args) =>
            err ? reject(err) : resolve(args)))
}

export function from(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, (...args) => resolve(args)))
}

export function maybe(f, ...params)
{
    return from.call(this, f, ...params)
    .then(([err, ...args]) => ({err, args, val: args[0]}))
}
