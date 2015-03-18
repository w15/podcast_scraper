json.array!(@episodes) do |episode|
  json.extract! episode, :id, :title, :desc, :dl_link, :image_url, :date, :ep_url
  json.url episode_url(episode, format: :json)
end
