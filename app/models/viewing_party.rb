class ViewingParty < ApplicationRecord
  has_many :viewing_party_users
  has_many :users, through: :viewing_party_users

  validate :party_date_cannot_be_in_the_past
  validate :duration_cannot_be_less_than_movie

  validates_presence_of :party_date, :party_time

  def party_date_cannot_be_in_the_past
    return unless party_date.present? && party_date < Date.today
    
    errors.add(:party_date, 'cannot be in the past')
  end

  def duration_cannot_be_less_than_movie
    movie_runtime = MovieFacade.new(movie_id: movie_id).movie.runtime

    return unless duration_minutes < movie_runtime

    errors.add(:duration_minutes, 'cannot be less than movie runtime')
  end

  def host
    users.where(id: self.host_id).first
  end

  def guests
    users.where.not(id: self.host_id)
  end
end
