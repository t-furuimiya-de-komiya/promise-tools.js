require! <[chai chai-as-promised]>

chai.use chai-as-promised

export chai.expect
export promise = require '..'

export function delay t
    new Promise (|> set-timeout(_, t))
