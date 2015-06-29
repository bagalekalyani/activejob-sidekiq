class TestJob < ActiveJob::Base
  queue_as :high

  # after_perform :notify_user

  # def perform(*args)
  #   Rails.logger.debug "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
  # end
  ## Call this from command prompt---- rails runner "TestJob.perform_later(1,2,3)" && sleep 3 && tail -n 4 log/development.log

  after_perform do |_job|
    self.class.set(wait: 1.minutes).perform_later
  end


  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      users = User.all
      users.each do |u|
        u.flag == true ? u.update_attributes(flag: false) : u.update_attributes(flag: true)
      end
    end
    puts "Successfully executed perform and update value !!!!!!!!!!!"
  end

  private

  def notify_user
    SampleMailer.sample_email(User.first.email).deliver_now
  end

end
