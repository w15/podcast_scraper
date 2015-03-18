class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :desc
      t.string :dl_link
      t.string :image_url
      t.date :date
      t.string :ep_url

      t.timestamps null: false
    end
  end
end
