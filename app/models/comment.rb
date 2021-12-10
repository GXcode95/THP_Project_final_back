class Comment < ApplicationRecord
    validates :content, presence: true, length: { in: 2..300 }

    belongs_to :game
    belongs_to :user
end
