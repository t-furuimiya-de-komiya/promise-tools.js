import coroutine from './coroutine.mjs'
import * as vargs from './vargs.mjs'
import {make, from, maybe, maybep, delay} from './promise.mjs'

export default {
    make, from, maybe, maybep,
    delay,
    vargs, v: vargs,
    coroutine, co: coroutine,
}
