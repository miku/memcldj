README
======

Load JSON blobs into memcache or memcachedb quickly. Given an [LDJ](http://en.wikipedia.org/wiki/Line_Delimited_JSON)
file, use a value from inside a JSON document as key and set its value
to the JSON blob.

Note: Nested keys are not supported.

Installation
------------

    $ go get github.com/miku/memcldj/cmd/memcldj

Or install via [debian or rpm packages](https://github.com/miku/memcldj/releases).

Usage
-----

    $ memcldj
    Usage of memcldj:
      -addr="127.0.0.1:11211": hostport of memcache
      -b=10000: batch size
      -key="id": key to use
      -retry=10: retry set operation this many times
      -verbose=false: be verbose
      -w=4: number of workers

Example
-------

Example: Given a file with docs like

    $ cat file.ldj
    {"x": "a", "y": "A"}
    {"x": "b", "y": "B"}

Running:

    $ memcldj -key "x" file.ldj

Will set two keys, "a" and "b" in memcache with the corresponding JSON docs as values.

Example with more options:

    $ memcldj -w 2 -key "id" -verbose -addr 127.0.0.1:12345 fixtures/t0.ldj

If there's any error (i/o, timeout), memcldj will retry a few times with exponential backoff before giving up.
