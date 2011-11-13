#Proxy Manager

ProxyManager is Ruby class useful for web bots / scrapers or any other http requests whereby you need to limit how frequently you use the same proxy. This stops sites from blocking / filtering your IP.

You can set your own delay which is time that you want to leave a proxy to "cool down".The ideal amount for depends on how tolerant the site your scraping is, so you'll have to work that out on your own.

Inspired by the ProxyManager in mattseh's [python-web](https://github.com/mattseh/python-web) library, with a few additions / tweaks.

###Usage

You can pass either a array of proxies to the class, or you can specify
a file to load them from.

Proxies from array:

```ruby
prox = ["123.6.19.97:8088","189.122.171.234:6588","201.15.218.158:6588"]

# Passing in a array, time delay is 15secs
manager = ProxyManager.new(prox, 15)

```

Proxies from file:

```ruby
# Loading proxies directly from a file, delay is 20secs
manager = ProxyManager.from_proxy_file("path/to/proxy/file.txt", 20)

```

```ruby

prox = ["123.6.19.97:8088","189.122.171.234:6588","201.15.218.158:6588"]
manager = ProxyManager.new(prox, 15)

# Grab a proxy
proxy = manager.available_proxy
#=> "189.122.171.234:6588"

# Check if there is a proxy available for use
manager.proxy_available?
#=> true

# Check how many proxies are available to use
manager.available_count
#=> 2

# Grab two proxies
proxies = manager.available_proxies(2)
#=> ["123.6.19.97:8088","201.15.218.158:6588"]

# Check if there is a proxy available for use
manager.proxy_available?
#=> false

```
