'use strict';

function coroutine(it, recv)
{
    switch (Object.prototype.toString.call(it).slice(8, -1)) {
        case 'Promise':
            return it.then(coroutine)
        case 'GeneratorFunction':
            if (it.length > 0)
                return (...args) =>
                    scanGenerator(it.call(recv || this, ...args))
            it = it();
        case 'Generator':
            return scanGenerator(it)
        default:
            return Promise.resolve(it)
    }
}

async function scanGenerator(it)
{
    let {done, value} = it.next();
    while (!done) {
        try {
            ({done, value} = it.next(await value));
        } catch (err) {
            ({done, value} = it.throw(err));
        }
    }
    return value
}

module.exports = coroutine;
