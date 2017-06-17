const coroutine = require('./coroutine')
const vargs = require('./vargs')
const {make, from, maybe, maybep, delay} = require('./promise')

module.exports = {
    make, from, maybe, maybep,
    delay,
    vargs, v: vargs,
    coroutine, co: coroutine,
}
