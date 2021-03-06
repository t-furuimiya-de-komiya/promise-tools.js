'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

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

exports.make = make;
exports.from = from;
exports.maybe = maybe;
exports.maybep = maybep;
exports.delay = delay;
