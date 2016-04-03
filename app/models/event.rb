class Event < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.most_to_least_requested
    group(:name).order("count_all desc").count
  end

  def number_of_times_received
    payload_requests.count
  end

end
