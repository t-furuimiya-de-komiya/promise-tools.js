'use strict';

function timeout(t, f, msg)
{
    if (typeof msg === 'function' || typeof f === 'string')
        [f, msg] = [msg, f];
    msg = msg || f ? `timeout: ${msg || f.displayName || f.name || '[function]'}` : 'timeout';

    return new Promise((resolve, reject) => {
        setTimeout(() => reject(new Error(msg)), t);
        if (typeof f === 'function')
            f(resolve, reject);
    })
}

module.exports = timeout;
