{test, Promise} = require "snapy"

test (snap) =>
  # state only contains correct
  snap obj: {some:{path:"correct"}}, filter: "some.path"

test (snap) =>
  # should not include notIncluded
  snap obj: {multiple: true, paths: true, notIncluded: false}, filter: "multiple,paths"

test (snap) =>
  # should not include notIncluded
  snap obj: {multiple: true, paths: true, notIncluded: false}, filter: "-notIncluded"

test (snap) =>
  # should not include notIncluded
  snap obj: {nested:{notIncluded: false, included: true}}, filter: "nested,-nested.notIncluded"