class TestJob < ActiveJob::Base
  queue_as :high

  after_perform :notify_user

  # def perform(*args)
  #   Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
  # end
  ## Call this from command prompt---- rails runner "TestJob.perform_later(1,2,3)" && sleep 3 && tail -n 4 log/development.log


  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      users = User.all
      users.each do |u|
        u.flag == true ? u.update_attributes(flag: false) : u.update_attributes(flag: true)
      end
    end
  end

  private

  def notify_user
    SampleMailer.sample_email(User.first.email).deliver_now
  end

end
