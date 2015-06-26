class TestJob < ActiveJob::Base
  queue_as :high

  # after_perform :notify_user

  # def perform(*args)
  #   Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
  # end
  ## Call this from command prompt---- rails runner "TestJob.perform_later(1,2,3)" && sleep 3 && tail -n 4 log/development.log


  def perform_later
    ActiveRecord::Base.connection_pool.with_connection do
      users = User.where(flag: true)
      users.each do |u|
        u.update_attributes(flag: false)
      end
    end
  end

  # private

  # def notify_user
  #   NotificationMailer.job_done(User.firts).deliver_later
  # end

end
