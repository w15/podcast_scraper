namespace :podcasts do
  desc "scrape podcast episode info"
  task :scrape => :environment do
    url = "http://www.npr.org/programs/invisibilia/archive"

    agent = Mechanize.new

    page = agent.get(url)

    # 1) Try to pull out and print the episode titles from just the first page
    # 2) Pull out and print the episode descriptions from just the first page
    # 3) Pull out and save the mp3 download link, large episode image_url, date and episode url (show page)

    episodes = page.search('.episodeArchiveWrapper article')

    episodes.each do |ep|
      title = ep.search('h2.title').text
      desc = ep.search('.teaser').text

      # pulling out attributes
      # link_url = ep.search('a').attr('href')

      episode = Episode.new
      episode.title = title
      episode.desc = desc
      episode.save
    end


  end
end
