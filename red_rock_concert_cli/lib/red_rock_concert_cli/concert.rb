require 'pry'

class RedRockConcertCli::Concert
  attr_accessor :name, :opener, :date, :time, :tickets_URL

  @@all = []

  def initialize(name, opener, date, time, tickets_URL)
    @name = name
    @opener = opener
    @date = date
    @time = time
    @tickets_URL = tickets_URL
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_index(index)
    @@all[index]
  end
end