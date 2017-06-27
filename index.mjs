import coroutine from './coroutine.mjs'
import * as vargs from './vargs.mjs'
import {make, from, maybe, maybep, delay} from './promise.mjs'

const v = vargs
const co = coroutine
export {
    make, from, maybe, maybep,
    delay,
    vargs, v,
    coroutine, co,
}
