class Artwork < ApplicationRecord
    validates :title, uniqueness: { scope: :artist_id,
    message: "you already have a title of that name" }

    belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: 'User'


end