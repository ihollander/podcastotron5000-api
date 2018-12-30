require 'benchmark'

module RssBenchmarkTest
  class BenchIt
    def self.run
      Benchmark.bm do |benchmark|
        benchmark.report("RSS") do
          RssReader::PodcastParser.get_channel_info("http://feeds.gimletmedia.com/hearreplyall")
        end
      
        benchmark.report("Nokogiri") do
          RssNokogiri::PodcastParser.get_channel_info("http://feeds.gimletmedia.com/hearreplyall")
        end
      end
    end
  end
end