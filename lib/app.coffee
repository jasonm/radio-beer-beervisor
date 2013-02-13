ForceDiagram = require('lib/draw').ForceDiagram

exports.App =
  class App
    constructor: (appName, dbName, db) ->
      [@appName, @dbName, @db] = [appName, dbName, db]
      @nodes = []
      @links = []

    run: =>
      @fetch(@draw)

      changes = @db.changes()
      changes.onChange (data) =>
       console.log "gonna fetch"
       @fetch(@diagram.update)

    fetch: (cb) =>
      d3.json '_view/scanNodes?group=true', (res) =>
        nodes = _.pluck(res.rows, 'key')
        nodeNames = _.pluck(nodes, 'name')
        d3.json '_view/rfidScans?group=true', (res) =>
          links = _.map res.rows, (row) =>
            {
              value: 1
              'source': nodeNames.indexOf(row.key.source)
              'target': nodeNames.indexOf(row.key.target)
            }

          @updateNodes(@nodes, nodes)
          @updateLinks(@links, links)
          cb() if cb

    draw: =>
      console.log "sup"
      @diagram = new ForceDiagram(@nodes, @links)

    updateNodes: (array, newArray) =>
      hasItem = (ary, candidate) ->
        _.detect ary, (item) ->
          item.name == candidate.name

      # remove ones that have disappeared
      # _.each array, (item) =>
      #   if ! hasItem(newArray, item)
      #     console.log("removing #{JSON.stringify(item)}")
      #     array.splice(array.indexOf(item), 1)

      # append newcomers
      _.each newArray, (item) =>
        if ! hasItem(array, item)
          console.log("adding #{JSON.stringify(item)}")
          array.push(item)

    updateLinks: (array, newArray) =>
      hasItem = (ary, candidate) ->
        _.detect ary, (item) ->
          (item.source == candidate.source) && (item.target == candidate.target)

      # remove ones that have disappeared
      # _.each array, (item) =>
      #   if ! hasItem(newArray, item)
      #     console.log("removing #{JSON.stringify(item)}")
      #     array.splice(array.indexOf(item), 1)

      # append newcomers
      _.each newArray, (item) =>
        if ! hasItem(array, item)
          console.log("adding #{JSON.stringify(item)}")
          array.push(item)
