draw = require('lib/draw').draw

exports.App =
  class App
    constructor: (appName, dbName, db) ->
      [@appName, @dbName, @db] = [appName, dbName, db]

    run: =>
      @db.view(appName + '/rfidScansByCreatedAtDesc', { success: @drawResult })

    drawResult: (result) =>
      readerDescriptions = _.map result.rows, (row) ->
        row.value.reader_description

      readerNodes = _.map readerDescriptions, (readerDescription) ->
        { 'name': readerDescription, 'group': 1 }

      tagIds = _.map result.rows, (row) ->
        row.value.tag_id

      tagNodes = _.map tagIds, (tagId) ->
        { 'name': tagId, 'group': 2 }

      nodeNames = _.union(_.uniq(readerDescriptions), _.uniq(tagIds))
      nodes = _.union(tagNodes, readerNodes)

      links = _.map result.rows, (row) ->
        readerIndex = nodeNames.indexOf(row.value.reader_description)
        tagIndex = nodeNames.indexOf(row.value.tag_id)

        # TODO: reduce to sum values
        { 'source': readerIndex, 'target': tagIndex, value: 1 }

      draw({ nodes: nodes, links: links })
