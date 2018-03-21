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

function scanGenerator(it)
{
    try {
        return genTail(it, it.next())
    } catch (err) {
        return Promise.reject(err)
    }
}

function genTail(it, cur)
{
    const {done, value} = cur;
    const p = Promise.resolve(value);
    return done ?
        p
    :
        p.then(
            (x => genTail(it, it.next(x))),
            (e => genTail(it, it.throw(e))))
}

module.exports = coroutine;
