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
      dl_link = ep.search('.download a').attr('href').text

      # pulling out attributes
      # link_url = ep.search('a').attr('href')

      ep_url = ep.search('a').attr('href').text
      date =  Date.parse(ep_url.split("showDate=").last)

      ep_show_page = agent.get(ep_url)
      image_url = ep_show_page.search('.mainImage img').attr('src')

      episode = Episode.find_by_title(title)
      if episode.blank?
        episode = Episode.new
        episode.title = title
        episode.desc = desc
        episode.date = date
        episode.dl_link = dl_link
        episode.image_url = image_url
        episode.save
      end
    end


  end
end
