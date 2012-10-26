class Broadcaster < ActiveRecord::Observer
  # Observe all models
  Rails.application.eager_load! if not Rails.application.config.cache_classes
  observe ActiveRecord::Base.subclasses.select { |cls| cls.respond_to?(:broadcast?) ? cls.send(:broadcast?) : true }

  def initialize()
    super
    self.observed_classes.each do |cls|
      cls.extend(Faye::ModelMehthods)
    end
  end

  def self.observed_classes
    ActiveRecord::Base.send(:subclasses)
  end

  def after_update(model)
    broadcast_event(model, :update)
  end

  def after_create(model)
    broadcast_event(model, :create)
  end

  def after_destroy(model)
    broadcast_event(model, :destroy)
  end

  def broadcast(model, event, data)
    model = model.class unless model.is_a?(Class)
    subchannel = model.respond_to?(:broadcast_channel) ? model.send(:broadcast_channel) : model.table_name
    message = {
      :channel => "/sync/#{subchannel}",
      :data => { event => data }
    }
    Rails.logger.info "Broadcasting #{message.inspect}"
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def broadcast_event(model, event)
    broadcast(model, event, { model.id => model.as_json })
  end
end

module Faye
  module ModelMehthods
    def broadcast(event, data)
      Broadcaster.instance.broadcast(self, event, data)
    end
  end
end