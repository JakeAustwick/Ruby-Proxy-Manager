#Proxy Manager

ProxyManager is Ruby class useful for web bots / scrapers or any other http requests whereby you need to avoid rate-limiting. 

You can set a delay for which is the minimum delay between which the same proxy will be returned again.

 Inspired by the ProxyManager in mattseh's [python-web](https://github.com/mattseh/python-web) library.

##Usage

You can pass either a array of proxies to the Class, or otherwise it will fallback to a file called **proxies.txt**.

```ruby
prox = ["123.6.19.97:8088","189.122.171.234:6588","201.15.218.158:6588"]

#passing in a array, time delay is 15secs
manager = ProxyManager.new(prox, delay=15)

#grab a proxy
proxy = manager.get

#=> "189.122.171.234:6588"

```
