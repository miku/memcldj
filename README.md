README
======

Load JSON blobs into memcache or memcachedb quickly. Given an [LDJ](http://en.wikipedia.org/wiki/Line_Delimited_JSON)
file, use a value from inside a JSON document as key and set its value
to the JSON blob.

Installation
------------

    $ go get github.com/miku/memcldj/cmd/memcldj

Or install via [debian or rpm packages](https://github.com/miku/memcldj/releases).

Example: Given a file with docs like

    $ cat file.ldj
    {"x": 2, "y": 4}
    {"x": 3, "y": 9}

Running:

    $ memcldj -key "x" file.ldj

Will set two keys, 2 and 3 in memcache with the corresponding JSON docs as values.

    $ memcldj
    Usage of memcldj:
      -addr="127.0.0.1:11211": hostport of memcache
      -b=10000: batch size
      -key="id": document key to use a id in dot notation
      -retry=10: retry set this many times
      -verbose=false: be verbose
      -w=4: number of workers

Example:

    $ memcldj -w 2 -key "id" -verbose -addr 127.0.0.1:12345 fixtures/t0.ldj

If there's any error (i/o, timeout), memcldj will retry with exponential backoff.
