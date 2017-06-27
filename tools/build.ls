require! rollup: {rollup}

<[coroutine promise seq timeout vargs]>.for-each build

function build entry
    dest = entry + \.js
    entry += \.mjs
    rollup {entry}
    .then (.write {dest, format: \cjs})
    .catch ->
        if it.frame
            console.error it.message
            console.error it.frame
        else
            console.error it
