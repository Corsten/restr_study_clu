require 'rss'

class RssConverter
  def self.convert(data)
    rss = RSS::Maker.make("2.0") do |m|
      m.channel.author  = "Steve Wattam"
      m.channel.updated = Time.now
      m.channel.about   = "http://stephenwattam.com/blog/"
      m.channel.title   = "Steve W's Blog"
      m.channel.link    = "test.com"
      m.channel.description = "Test"
    end

    puts data
  end
end