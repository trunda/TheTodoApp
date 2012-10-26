class Task < ActiveRecord::Base
  attr_accessible :due, :notes, :title, :completed, :position

  def self.sort(params)
    params.each do |key, item|
      Task.update_all({:position => item[:position]}, {:id => item[:id]})
    end
    Task.broadcast(:resort, params)
  end
end
