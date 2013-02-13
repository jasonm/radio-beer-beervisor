exports.views =
  rfidScansByCreatedAtDesc:
    map: (doc) ->
      if doc.type == 'rfid-scan'
        if doc.created_at
          emit(-Date.parse(doc.created_at), doc)
        else
          emit(0, doc)

  #group=true
  scanNodes:
    map: (doc) ->
      if doc.type == 'rfid-scan'
        emit({ group: 1, name: doc.reader_description },  doc)
        emit({ group: 2, name: doc.tag_id }, doc)

    reduce: (keys, values) ->
      null

  rfidScans:
    map: (doc) ->
      if doc.type == 'rfid-scan'
        emit({ source: doc.reader_description, target: doc.tag_id }, doc)

    reduce: (keys, values) ->
      null
