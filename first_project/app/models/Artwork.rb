class Artwork < ApplicationRecord
    validates :title, :image_url, presence: true
    validates :image_url, uniqueness: true
    validates :title, uniqueness: { scope: :artist_id,
    message: "you already have a title of that name" }

    #rails 5 will automatically validate the artist_id to be present
    belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: 'User'

    has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'ArtworkShare'

    has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

    has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Comment
    
    has_many :likes, as: :likeable

    has_many :users_who_liked,
    through: :likes,
    source: :user
end