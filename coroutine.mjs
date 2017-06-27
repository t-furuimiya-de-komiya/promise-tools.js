
export default function coroutine(it, recv)
{
    switch (Object.prototype.toString.call(it).slice(8, -1)) {
        case 'Promise':
            return it.then(coroutine)
        case 'GeneratorFunction':
            if (it.length > 0)
                return (...args) =>
                    scanGenerator(it.call(recv || this, ...args))
            it = it()
        case 'Generator':
            return scanGenerator(it)
        default:
            return Promise.resolve(it)
    }
}

function scanGenerator(it, prev)
{
    try {
        let {done, value} = it.next(prev)
        return Promise.resolve(value)
        .catch(err => (it.throw(err), prev))
        .then(val => done ? val : scanGenerator(it, val))
    } catch (err) {
        return Promise.reject(err)
    }
}
