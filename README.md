README
======

Load JSON blobs into memcache or memcachedb quickly.

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

If there's an i/o error, retry with exponential backoff.
