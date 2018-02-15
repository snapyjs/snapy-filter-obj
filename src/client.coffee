module.exports = client: ({snap,position,util:{isString,isArray}}) ->
  snap.hookIn position.during-1, ({state}) ->
    if (filter = state.filter)? and (obj = state.obj)?
      delete state.filter
      if isString(filter)
        filter = filter.replace(/[,;]/g," ").replace(/\s+/g," ").split(" ")

      if isArray(filter)
        paths = filter.reduce ((acc,curr) -> 
            if curr[0] == "-"
              acc.rem.push curr.slice(1)
            else if curr[0]?
              acc.add.push curr
            return acc
          ), add: [], rem: []
        if paths.add.length > 0
          try
            obj = paths.add.reduce ((result, path) -> 
              unless (result[path] = path.split(".").reduce ((acc,curr) -> 
                return acc[curr] if acc[curr]?
                console.error "path not valid: #{path}"
                return null
                ), obj)?
                delete result[path]
              return result
              ), {}
        if paths.rem.length > 0
          paths.rem.forEach (path) ->
            {tree} = path.split(".").reduce ((acc, curr) -> 
              acc.tree.push [curr, acc.next]
              acc.next = acc.next?[curr]
              return acc
            ),tree: [], next: obj
            for [key, obj2] in tree.reverse()
              if obj2?
                delete obj2[key]
                if Object.keys(obj2).length > 0
                  break
        
        if (tmp = Object.keys(obj)).length == 1
          state.obj = obj[tmp[0]]
        else
          state.obj = obj
      