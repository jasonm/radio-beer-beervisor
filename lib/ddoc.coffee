exports.views =
  rfidScansByCreatedAtDesc:
    map: (doc) ->
      if doc.type == 'rfid-scan'
        if doc.created_at
          emit(-Date.parse(doc.created_at), doc)
        else
          emit(0, doc)
