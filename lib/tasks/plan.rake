namespace :plan do
  desc 'charge users yearly for background check'
  task update_plan: :environment do
    arr = [["plan_GvSXffpsk5c6oS", "plan_GvSX7T38sC7nBd", "plan_GvSXADhBB5VfJB", "plan_GvSXjwoSxqWsTq", "plan_GvSXRA255w4Xiq", "plan_GvSXdjqm7KPeHu", "plan_GvSX01SF9eHHko", "plan_GvSXrirTMTbTKp", "plan_GvSXoD1WHZroow", "plan_Gz7xHtXHIsZ4ol"]]
    data = Stripe::Plan.list(:limit => 100)
    
    data['data'].each do |s|
        p = Plan.find_by_planId(s.id)
        if p.nil?
          Plan.create(min: 1, max: 10, planId: s.id,  price: s.amount, status: "active")
        end  
    end 
    arr.each do |a|

    end 
  end  

  task update_bed: :environment do
        plans = Plan.where(:status => 0)
        plans.each do |s|
          product_id = Stripe::Plan.retrieve(s.planId).product
          
          product = Stripe::Product.retrieve(product_id).name
          if product.include?("Yearly")
             bed = product[6..(product.index('Yearly')-2)]
             arr = bed.split("-")
             s.update_attribute("min", arr[0])
             s.update_attribute("max", arr[1])
             s.update_attribute("has_bed", true)
             s.update_attribute("is_yearly", true)
             
          end 
          if product.include?("Monthly")
             bed = product[6..(product.index('Monthly')-2)]
             arr = bed.split("-")
             s.update_attribute("min", arr[0])
             s.update_attribute("max", arr[1])
             s.update_attribute("has_bed", true)
          end  
          if product.include?("6-month free trial")
             s.update_attribute("has_trial_period", true)
          end 

          s.update_attribute("nickname", product)
          s.update_attribute("amount", s.price)


        end  
       
    
  end  

end


# ["price_1Jpd0dDNmkOyGUyUD9DuUW4C", "price_1Jpd0FDNmkOyGUyUXw9iBUbP", "price_1JpczdDNmkOyGUyUaJEOvWCI", "price_1JpczEDNmkOyGUyUG2KGWapR", "price_1JpcykDNmkOyGUyUEVaZhA7u", "price_1JpcyPDNmkOyGUyUtqR7H5wd", "price_1Jpcy4DNmkOyGUyUKLbUfGhM", "price_1JpcxhDNmkOyGUyU704PYmCE", "price_1JpcxNDNmkOyGUyU4mM4ehxW", "price_1Jpcx4DNmkOyGUyUZTUKRa9e", "price_1JpcwlDNmkOyGUyU6019wGxx", "price_1JpcwNDNmkOyGUyUHF5mJK5M", "price_1JpcuMDNmkOyGUyU2dqhjhe7", "price_1JpctvDNmkOyGUyUQvDfCrze", "price_1JpctYDNmkOyGUyUieSKmqDo", "price_1JpcsuDNmkOyGUyUtzvf9Hxp", "price_1JpcsUDNmkOyGUyUjGuqT10Z", "price_1JpcrtDNmkOyGUyUCjFMEIqO", "price_1JpcrODNmkOyGUyU8lcBgmEw", "price_1JpcSDDNmkOyGUyUaTwSRuZE", "price_1JpcRnDNmkOyGUyUwOtHZ9jx", "price_1JpcRDDNmkOyGUyUU30eujhd", "price_1JpcQsDNmkOyGUyUxtTaR02H", "price_1JpcQVDNmkOyGUyUDCOA7CDV", "price_1JpcQ9DNmkOyGUyUooRXMO7a", "price_1JpcPqDNmkOyGUyUhKU4f3xX", "price_1JpcPVDNmkOyGUyUSe9oi7Y7", "price_1JpcP6DNmkOyGUyUxCTrxNu7", "price_1JpcObDNmkOyGUyUjJcAw0ku", "price_1JpcOEDNmkOyGUyURTkp4LEY", "price_1JpcNsDNmkOyGUyUhBs4g0CQ", "price_1JpcNVDNmkOyGUyUlZ7Vi6sb", "price_1JpcN8DNmkOyGUyUKHtyFEu6", "price_1JpcMjDNmkOyGUyUonQHtyKR", "price_1JpcLkDNmkOyGUyUEjLeOAAF", "price_1JpcLNDNmkOyGUyULLBmw2yr", "price_1JpcKsDNmkOyGUyUbbGkLYNC", "price_1JpcKQDNmkOyGUyU7QUuRPGO", "plan_Gz7xHtXHIsZ4ol", "plan_GvSXoD1WHZroow", "plan_GvSXrirTMTbTKp", "plan_GvSX01SF9eHHko", "plan_GvSXdjqm7KPeHu", "plan_GvSXRA255w4Xiq", "plan_GvSXjwoSxqWsTq", "plan_GvSXADhBB5VfJB", "plan_GvSX7T38sC7nBd", "plan_GvSXffpsk5c6oS"]