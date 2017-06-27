
export function make(f, ...args)
{
    return new Promise((resolve, reject) =>
        f.call(this, ...args, (err, ret) =>
            err ? reject(err) : resolve(ret)))
}

export function from(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, resolve))
}

export function maybe(f, ...params)
{
    return new Promise(resolve =>
        f.call(this, ...params, (err, val) =>
            resolve({err, val})))
}

export function maybep(p)
{
    return p.then((val => ({val})), (err => ({err})))
}

export function delay(t)
{
    return new Promise(resolve => setTimeout(resolve, t))
}
