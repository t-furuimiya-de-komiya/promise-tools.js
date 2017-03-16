require! './test.ls': {promise, expect, delay}
require! '../src/timeout'

suite \#timeout

test 'timeout' ->
    expect timeout 1
    .to.be.rejected-with Error, /^timeout$/

test 'timeout with message' ->
    expect timeout 1, \msg
    .to.be.rejected-with Error, /^timeout: msg$/

test 'timeout then resolve' ->
    expect timeout 1, (|> set-timeout(_, 10))
    .to.be.rejected-with Error, /^timeout: \[function\]$/

test 'timeout then resolve with function displayName' ->
    long-resolve = (|> set-timeout(_, 10))
    long-resolve.display-name = \long-resolve
    expect timeout 1, long-resolve
    .to.be.rejected-with Error, /^timeout: long-resolve$/

test 'resolve then timeout' ->
    expect timeout 1, (<| \resolved)
    .to.become \resolved

test 'timeout then reject with function name' ->
    expect timeout 1, longReject
    .to.be.rejected-with Error, /^timeout: longReject$/

test 'timeout then reject with message before function' ->
    expect timeout 1, \before, longReject
    .to.be.rejected-with Error, /^timeout: before$/

test 'timeout then reject with message after function' ->
    expect timeout 1, longReject, \after
    .to.be.rejected-with Error, /^timeout: after$/

test 'reject then timeout' ->
    expect timeout 1, (resolve, reject) -> reject new Error \rejection
    .to.be.rejected-with Error, /^rejection$/

function longReject resolve, reject
    set-timeout reject, 10
