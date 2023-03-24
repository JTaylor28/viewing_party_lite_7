class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  validate :party_date_cannot_be_in_the_past
  validate :duration_cannot_be_less_than_movie
  
  validates_presence_of :party_date, :party_time

  def party_date_cannot_be_in_the_past
    if party_date.present? && party_date < Date.today
      errors.add(:party_date, "can't be in the past")
    end
  end

  def duration_cannot_be_less_than_movie
    movie_runtime = MovieFacade.new(movie_id: self.movie_id).movie.runtime

    if duration_minutes < movie_runtime
      errors.add(:duration_minutes, "cannot be less than movie runtime")
    end
  end
end
