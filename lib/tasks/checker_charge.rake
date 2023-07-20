namespace :checker_charge do
  desc 'charge users yearly for background check'
  task charge: :environment do
    checker_fee = 2500
    @users = User.users_applicable_for_checker_charge
    if @users.present?
      @users.each do |user|
        user.cares.updtae_all(status: 'in-progress')
        Stripe::Charge.create({
          amount: checker_fee,
          currency: 'inr',
          customer: user.stripeID,
          description: "Charge for #{user.email}",
        })
        puts "#{user.full_name} has be charged for checker renewal"
        user.update!(checker_paid_date: Date.today, checker_future_payment: Date.today + 1.year)

      rescue Stripe::InvalidRequestError, StandardError => e
        Bugsnag.notify(e)
      end
    else
      puts 'No user for checkr renewal'
    end
  end

end