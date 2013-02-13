Beervisor
========================

Advanced visualization technology.

![](http://4.bp.blogspot.com/-FLGOozOnnug/Th4F6peNcyI/AAAAAAAAAOY/GGboWTb-x58/s1600/vr-headset.jpeg)


Prerequisites
-------------

Get couchdb:

```
brew install couchdb
```

Install node and npm:

```
brew install node
```

Install some build tools:

```
gem install watchr
```

Installation
------------

Install dependencies:

```
kanso install
```

Specify the name of the local (and, optionally, production) database you want
to deploy to:

```
cp kansorc.example .kansorc
```

Now, edit `.kansorc` to change the local or production database.

Deploy:

```
kanso push
```

You should see output ending with something like:

```
Build complete: 131ms
Uploading...
OK: http://localhost:5984/radio_beer_development/_design/bartender/index.html
```

Open that URL to view the app.


Development
-------------

As you develop, automatically rebuild the site with `watchr`:

```
watchr kanso.watchr
```

Save your hard-earned keystrokes.  Automatically reload the browser when
a rebuild happens with `live-reload` (the build touches `tmp/livereload.txt`
to initiate this handoff):

```
npm install -g live-reload
live-reload tmp/livereload.txt
```

Test Data
-----------------

Create rfidscan events with the `CouchLogger` separate `CouchLogger` tool.

Deployment
-----------------

When you are ready to go live, make sure `.kansorc` has the correct credentials
under the `production` key, then push:

```
kanso push production
```

Notes
===================

Maybe use view filtering?

https://issues.apache.org/jira/browse/COUCHDB-1398
  via http://comments.gmane.org/gmane.comp.db.couchdb.user/14891
