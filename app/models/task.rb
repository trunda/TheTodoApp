class Task < ActiveRecord::Base
  attr_accessible :due, :notes, :title, :completed, :position

  def self.broadcast?
    false
  end
end
