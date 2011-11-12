#Proxy Manager

ProxyManager is Ruby class useful for web bots / scrapers or any other http requests whereby you need to limit how frequently you use the same proxy. This stops sites from blocking / filtering your IP.

You can set your own delay which is time that you want to leave a proxy to "cool down".The ideal amount for depends on how tolerant the site your scraping is, so you'll have to work that out on your own.

Inspired by the ProxyManager in mattseh's [python-web](https://github.com/mattseh/python-web) library, with a few additions / tweaks.

###Usage

You can pass either a array of proxies to the Class, or otherwise it will fallback to a file called **proxies.txt**.

```ruby
prox = ["123.6.19.97:8088","189.122.171.234:6588","201.15.218.158:6588"]

# Passing in a array, time delay is 15secs
manager = ProxyManager.new(prox, delay=15)

# Grab a proxy
proxy = manager.get
#=> "189.122.171.234:6588"

# Check theres a proxy available for use
manager.proxy_available?
#=> true

# Grab two proxies
proxies = manager.get_multiple(2)
#=> ["123.6.19.97:8088","201.15.218.158:6588"]

```
