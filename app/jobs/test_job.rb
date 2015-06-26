class TestJob < ActiveJob::Base
  queue_as :high

  # def perform(*args)
  #   Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
  # end

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      users = User.where(flag: false)
      users.each do |u|
        u.update_attributes(flag: true)
        u.save
      end
    end
  end

end
