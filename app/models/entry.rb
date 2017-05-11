class Entry < ActiveRecord::Base
  validates :title, :body, { presence: true }
  belongs_to :user

  def self.most_recent
    Entry.order(created_at: :desc).limit(5)
  end
end
