class ProxyManager

  def initialize(proxy=true, delay=10)
    proxies = Array.new

    # Use the array of proxies passed in
    if proxy.is_a? Array
      proxies = proxy
    elsif proxy == true
      # Use a text file in the same directory as a fallback
      proxies = IO.readlines("proxies.txt").map{ |line| line.strip}
    else
      proxies = nil
    end

    @delay = delay
    @records = proxies.map{ |element| [element, 0]}
  end


  def get
    while true
      choices = @records.select{ |_, delay| delay < (Time.now.to_i - @delay)}

      if choices.empty?
        sleep(1)
      else
        proxy = choices.sample
        @records[@records.index(proxy)][1] = Time.now.to_i
        break
      end

    end

    return proxy[0]
  end


  def get_multiple(n)
    if n > @records.size
      return nil
    end

    while true
      choices = @records.select{ |_, delay| delay < (Time.now.to_i - @delay)}

      if n > choices.size
        sleep(1)
      else
        proxies = choices.sample(n)
        proxies.each do |proxy|
          @records[@records.index(proxy)][1] = Time.now.to_i
        end
        break
      end

    end

    return proxies.map!{ |p| p[0]}
  end


  def proxy_available?
    !@records.select{ |_, delay| delay < (Time.now.to_i - @delay)}.empty?
  end

  def available_count?
    @records.select{ |_, delay| delay < (Time.now.to_i - @delay)}.size
  end

end
