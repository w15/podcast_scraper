namespace :podcasts do
  desc "scrape podcast episode info"
  task :scrape => :environment do
    url = "http://www.npr.org/programs/invisibilia/archive"

    agent = Mechanize.new

    page = agent.get(url)

    # 1) Try to pull out and print the episode titles from just the first page
    # 2) Pull out and print the episode descriptions from just the first page

    episodes = page.search('.episodeArchiveWrapper article')

    episodes.each do |ep|
      puts ep.search('h2.title').text
      puts ep.search('.teaser').text
    end


  end
end
