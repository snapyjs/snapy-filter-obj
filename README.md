# snapy-filter-obj

Plugin of [snapy](https://github.com/snapyjs/snapy).

Filter properties from a snapshot, like timestamps.

```js
test((snap) => {
  snap({
    obj: {
      nested:{
        notIncluded: false, 
        included: true
      },
      alsoNotIncluded: false
    }, 
    filter: "nested,-nested.notIncluded"
  })
})
```

## License
Copyright (c) 2017 Paul Pflugradt
Licensed under the MIT license.
