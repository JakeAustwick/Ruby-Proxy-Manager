class ProxyManager

  class Proxy
    attr_reader   :address
    attr_accessor :last_used

    def initialize(address, last_used=nil)
      @address    = address
      @last_used  = last_used
    end

    def used_since?(time)
      @last_used && @last_used > time
    end

    def to_s
      @address
    end
  end

  def self.from_proxy_file(path="proxies.txt", delay=10)
    proxies = IO.readlines(path).map { |line| line.strip }

    new(proxies, delay)
  end

  def initialize(proxies, delay=10)
    raise ArgumentError, "proxies must contain at least 1 proxy" if proxies.empty?
    raise ArgumentError, "proxies must be unique, but duplicates were found: #{duplicates(proxies).join(', ')}" if proxies.size != proxies.uniq.size

    @addresses  = proxies
    @delay      = delay
    @proxies    = proxies.map { |address| Proxy.new(address) }
  end

  def duplicates(list)
    list.group_by { |e| e }.select { |k,v| v.size > 1 }.map(&:first)
  end

  #   A proxy that hasn't been used for at least #delay seconds.
  #   If none is available, the method will block until one becomes available
  def available_proxy
    proxy = @proxies.shift
    @proxies << proxy

    if proxy.last_used then
      nap_time  = @delay - (Time.now - proxy.last_used)
      sleep(nap_time) if nap_time > 0
    end
    proxy.last_used = Time.now

    proxy
  end

  #   This will block until n proxies are available
  def available_proxies(n)
    return nil if n > @proxies.size

    proxies = @proxies.shift(n)
    proxy   = proxies.last
    @proxies.concat(proxies)

    if proxy.last_used then
      nap_time  = @delay - (Time.now - proxy.last_used)
      sleep(nap_time) if nap_time > 0
    end
    proxies.each do |proxy|
      proxy.last_used = Time.now
    end

    proxies
  end

  def proxy_available?
    !@proxies.first.used_since?(Time.now-@delay)
  end

  def available_count
    time  = Time.now-@delay
    index = @proxies.find_index { |proxy| proxy.used_since?(time) }

    index ? index : @proxies.size
  end
end
