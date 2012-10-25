class Broadcaster < ActiveRecord::Observer
  # Observe all models
  Rails.application.eager_load! if not Rails.application.config.cache_classes
  ActiveRecord::Base.subclasses.each do |cls|
    observe cls if (cls.respond_to?(:broadcast?) && cls.send(:broadcast?)) || true
  end

  def self.observed_classes
    ActiveRecord::Base.send(:subclasses)
  end

  def after_update(model)
    broadcast(model, :update)
  end

  def after_create(model)
    broadcast(model, :create)
  end

  def after_destroy(model)
    broadcast(model, :destroy)
  end

  private
    def broadcast(model, event)
      subchannel = model.class.respond_to?(:broadcast_channel) ? model.send(:broadcast_channel) : model.class.table_name
      message = {
        :channel => "/sync/#{subchannel}",
        :data => { event => { model.id => model.as_json } }
      }
      Rails.logger.info "Broadcasting #{message.inspect}"
      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    end

end