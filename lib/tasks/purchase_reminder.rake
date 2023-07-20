namespace :purchase_reminder do
  desc 'sends mail to user reminding to purchase subscription'
  task reminder: :environment do
    @users = User.users_with_care_as_pending
    if @users.present?
      @users.each do |user|
        UserMailer.send_to_remind_buy_subscription(user).deliver
        user.update(email_sent: true)
      end
    else
      puts 'No user with care status as pending'
    end
  end

  desc 'sends mail to user reminding to complete checkr form'
  task checkr: :environment do
    @users = User.user_with_incomplete_checkr
    if @users.present?
      @users.each do |user|
        UserMailer.with(user: user).send_reminder_to_fill_checkr_form.deliver
      end
    else
      puts 'No user left to fill form'
    end
  end

end