# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = %w[admin provider customer social_worker]
roles.each do |name|
  Role.create(name: name)
end

User.create(first_name: 'Poornima', last_name: 'Admin', email: 'admin@mihygge.com',
	    password: '12345678', password_confirmation: '12345678', above18: true, role: Role.first)

# plans = { '1-10' => 19988, '11-20' => 23988, '21-30' => 35988, '31-60' => 47988, '61-100' => 59988, '101-150' => 83988, '151-200' => 119988, '201-above' => 155988, 'checkr' => 2500 }
# pl.each do |name, amount|
#   plan = Stripe::Plan.create(
#     amount: amount,
#     currency: 'usd',
#     interval: 'year',
#     product: { name: 'Mihygge' },
#     nickname: name
#   )
#   # min = name.split('-')[0].to_i
#   # max = name.split('-')[1].to_i
#   # if name == '201-above'
#   #   min = 201
#   #   max = 1000
#   # end
#   # if name == 'checkr'
#   #   min = -25
#   #   max = -25
#   # end
# 	# Plan.create(min: min , max: max, planId: plan.id, price: amount)
# end

# Stripe::Coupon.create(percent_off: 10, duration: 'forever')

staff_roles = ['Owner', 'Administrator', 'Executive_director', 'Admissions Director', 'Activities Director', 'Social Worker', 'Manager', 'Bereavement Counselor', 'Medication Management Supervisor',
'Clinician', 'In-house Doctor', 'In-house Podiartist', 'In-house Dentist', 'In-house Rehab/Fitness Director', 'Nurse', 'Nursing Assistant', 'Caregiver' ]

staff_roles.each do |name|
  StaffRole.create(name: name)
end

room_types = ['Dining room', 'Living room', 'Kitchen', 'Parking Lot', 'Patio', 'Garden Facility', 'Green house', 'Pool',
'Fountain', 'Lawn', 'Garden Bed']

room_types.each do |rt|
  RoomType.create(name: rt)
end

service_types = ['Care Provided', 'General & Wellness', 'Transportation', 'Fitness', 'Personal Hygiene', 'Recreation', 'Medication Management', 'Dining', 'Visual & Auditory Aids',
'Type of house', 'Share room with', 'Services nearby']

service_types.each do |st|
  if ['Type of house', 'Share room with', 'Services nearby'].include? st
    ServiceType.create(name: st, available_for: 'homeshare')
  elsif st == 'Care Provided'
    ServiceType.create(name: st, available_for: 'homeshare')
    ServiceType.create(name: st, available_for: 'senior_living')
  else
    ServiceType.create(name: st, available_for: 'all_care_types')
  end
end


care_services = [{'Care Provided senior living' => ['Assisted Living', 'Independent Senior Living', 'Care homes', 'Memory Care', 'CCRC', 'SNP',
'Long Term Care', 'Senior Apartment', 'Co-operative Housing', 'Retirement Village', 'Hospice/palliative Care', 'Respite Care', 'Multi-unit Housing', 'Vacation Care', 'Medical Tourism', 'Adult Day Care']},
{'General & Wellness' => ['Drinking Water Access', 'Laundry', 'HouseKeeping', 'Bathing Services', 'Beauty Salon', 'Podiatry Visit', 'Nursing aid', 'Nutritionist', 'Dietician', 'Occupational Therapist', 'Physical Therapist', 'Social Worker', 'Grief Counselling', 'Rehabilitation', 'Speech Therapist', 'Chaplain', "Spirituality / Religion", 'Religious Gathering', 'Sink', 'Kichenette', 'Compatible for disabled'] },
{'Transportation' =>['Self', 'Assisted']},
{'Fitness' => ['In-house gym', 'Personal Fitness Trainer']},
{'Personal Hygiene' => ['Self Care', 'Assisted/Supervised']},
{'Recreation' => ['In-house Activity', 'External Outing', 'Pet Therapy/Visit']},
{'Medication Management' => ['Take Own Medicine', 'Medication Assistance', 'Medication supervision']},
{'Dining' => ['Dining Assistance', 'Dining Non-Assistance', 'Room Service']},
{'Visual & Auditory Aids' => ['Braille', 'Tactile Signs', 'Auditory Guidance']},
{'Type of house' => ['Independent house', 'Apartment/Condo', 'Private Entrance']},
{'Share room with' => ['Seniors only']},
{'Services nearby' => ['Medical Services Nearby', 'Public Transport Nearby', 'Places of worship Nearby'] },
{'Care Provided homeshare' => ['Independent', 'Assisted', 'Bed Bound', 'Multi-unit Housing']}]


care_services.each do |cs|
  cs.each do |k, v|
    if k == 'Care Provided senior living'
      service_type_id = ServiceType.where(name: 'Care Provided', available_for: 'senior_living' ).first.id
    elsif k == 'Care Provided homeshare'
      service_type_id = ServiceType.where(name: 'Care Provided', available_for: 'homeshare' ).first.id
    else
      service_type_id = ServiceType.where(name: k).first.id
    end
    v.each do |value|
      Service.create(name: value, service_type_id: service_type_id)
    end
  end
end



care_facilities = [{'Amenities' => ['Wheel Chair Access', 'Ramp', 'Vending Machine', 'Green Living', 'Walker', 'Cane bound', 'Total Care', 'Lift', 'Non-Smoking', 'Designated Smoking Area', 'Private Guide Tour', 'Direct Access to street or ground floor' ]},
{'Entertainment & Media' => ['Internet Lounge', 'WiFI', 'Cable TV', 'In-house entertainment', 'Newspaper/Magazine', 'Library', 'Newsletter']},
{'Food & Stores' => ['In-house store', 'In-house restaurant', 'In-house cafe', 'Take out menu', 'Gift shop']},
{'Parking' => ['private', 'Valet', 'Street', 'Guest', 'Parking Type - Free', 'Parking Type - Paid']},
{'Business Facilities' => ['Fax/photocopying', 'Charging Station', 'Multipurpose Room', 'ATM']},
{'Utility' => ['Air-conditioning', 'Fans', 'Heating']},
{'Health & Fitness' => ['In-house gym', 'Community gym']},
{'Pets' => ['Pets in residence', 'Personal pets allowed']},
{'Meals' => ['Breakfast', 'Midmorning Snack', 'Lunch', 'Dinner', 'Evening Snack']},
{'Fire' => ['Smoke Alarms', 'Carbon Monoxide Alarms', 'Fire Extinguisher', 'Sprinkler Systems']},
{'Lighting' => ['Wireless Motion Sensing Lights', 'Touch Lamp', 'Automatic Night Lights']},
{'General' => ['Home Emergency Response', 'Personal Emergency Response', 'Handrails in stairs', 'Handrails in room']},
{'24 Hours' => ['24 Hour Security', '24 Hour supervision(Individual)', '24 Hour supervision(Group)']}
]

care_facilities.each do |cf|
  cf.each do |k, v|
    ft = FacilityType.create(name: k)
    v.each do |value|
      Facility.create(name: value, facility_type_id: ft.id)
    end
  end
end


room_services = [{'Utility' => ['Air-conditioning', 'Fans', 'Heating']},
{'Amenities' => ['Wheel chair', 'Internet/WIFI', 'Newspaper', 'HouseKeeping', 'Cable TV', 'Patio', 'Laundry',
'Dry Cleaning', 'Iron Services', 'Portable Refrigerator', 'Microwave', 'Access to Drinking water (tap)', 'Designated smoking area']},
{'Bathroom/Toilet' => ['Handrails in Toilet/Restroom', 'No Skid Shower Mat', 'Portable Toilet', '
  Raised Toilet Seat', 'Grab bar next to commode', 'Shower', 'Grab bar']},
{'Shower' => ['Non Slip Mat', 'Walker Access', 'Wheel Chair Access', 'Shower Chair',
'Transfer Bench', 'Walk-in Tub', 'Items within reach', 'Bath/hoyer lift', 'Hot Tub', 'Jacuzzi', 'Sauna']},
{'Lighting' => ['Wireless Motion Sensing Lights', 'Touch Lamp', 'Automatic Night Lights']},
{'Fire' => ['Smoke Alarms', 'Carbon Monoxide Alarms', 'Fire Extinguisher', 'Sprinkler Systems', 'Fire Safety Features']}]

room_services.each do |cf|
  cf.each do |k, v|
    ft = RoomServiceType.create(name: k)
    v.each do |value|
      RoomService.create(name: value, room_service_type_id: ft.id)
    end
  end
end


ServiceType.where(available_for: 'senior_living').first.services.each do |service|
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Assisted Living').first.update(desc: "A system of housing and limited care that is designed for senior citizens who need some assistance with daily activities but do not require care in a nursing home.
Facility provides meals, light housekeeping, bathing, dressing, mobility, social outings or in
house activities, transportation to and from a physician’s office or outpatient rehabilitation,
medication management and personal services, either free or at an extra cost. The rooms may
be private or shared and have an attached bathroom and toilet or restroom. The can provide
higher level of care depending on the facility policies and capabilities. They allow home health,
hospice and home care organizations to service their residents in need and cater to respite care
as well.
")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Independent Senior Living').first.update(desc: "Independent senior living communities (also known as retirement
communities, senior living communities or independent retirement communities) are housing
designed for seniors 55 and older, who want to live on their own, can access the conveniences
that an assisted living can offer, when and what they want or need. The rooms are usually
private, with an attached bathroom and toilet or restroom. Costs for services may be additional.
They allow home health and home care organizations to service their residents in need.
")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Memory Care').first.update(desc: "These facilities can be assisted living facilities with one
section devoted to patients with cognitive issues, can be closed facilities to prevent unsafe
wandering outside, provide higher level of skilled care, usually 24 hours supervised care, with
provision of services similar to assisted living facility, and more if the senior needs total care or
hospice /end of life care (depending on the facility). The rooms are either private or shared and
usually have a bathroom and toilet or restroom. Costs may vary for additional services. They
allow home health, home care and hospice organizations to service their residents in need.")

  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Long Term Care').first.update(desc: "A facility either private or subsidized by government and public, where the
seniors need and are provided a high level of Long term care (care of the chronically sick seniors
or aged). The rooms can be private or shared and includes services, like meals, activities of daily
living, bathing, personal hygiene and others.")

  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Care homes').first.update(desc: "Board and care homes are special facilities designed to
provide those who require assisted living services including daily activities, but do not require
care in a nursing home, usually in a home like setting ( mostly 4-6 beds) and atmosphere, in a
regular neighborhood or community. These facilities can provide higher level of care, when
needed with seniors needing total care (bedbound, end of life /hospice) when licensed for such
care. They usually have either a private room with an attached bathroom or shared rooms with
a common bathroom. Costs may vary for additional services. They allow home health and home
care organizations to service their residents in need and must be hospice certified for hospice
care.")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'CCRC').first.update(desc: "These facilities include within their premises - independent living, assisted living and skilled nursing facility.  CCRCs provide a step down process in the journey of aging, as the seniors’ needs change over time. Seniors have the option here to live and spend the rest of their lives within one center, without having the fear of relocation, and a respectful way to age under one roof. This arrangement helps not only the seniors but also their family members from worrying about caregiving issues. The rooms are designed per the senior’s needs, comfort, abilities and usually either private or shared. Costs depend on the above and may vary from senior to senior. They allow home health, home care and hospice organizations to service their residents in need, or help in moving (accommodate) a resident to skilled nursing facility within their premises if needed for such services.")

  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'SNP').first.update(desc: "A skilled nursing facility is either a free standing or part of a hospital or health care system or CCRC facility. A place where seniors need post-acute, medically necessary professional services from physicians, nurses, physical and occupational therapists, speech therapists, nutritionists. These facilities are regulated by the country’s health care systems or can be private. The rooms range from private to share with an attached bathroom. Additional services are provided at a cost. Facilities are licensed by the federal and respective boards and must hold a valid license and comply with standards and provisions of care. Usually they provide a short stay and are a bridge between the hospital and the home or senior living facility. Sometimes seniors needing more complete care and unable to be cared for at home or unable to finance that care at home are also accepted either through private compensation or insurance or government subsidy. These facilities provide hospice/End of life care along with rehabilitation services and cater to a spectrum of seniors. They allow hospice and home care organizations for services to be rendered to their patients in need and cater to respite care as well.")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Senior Apartment').first.update(desc: "These facilities are independent units servicing seniors in the communities over the age of 55. Here the seniors are mostly independent, or may have an in-house caregiver according to their needs. These properties are usually single floor to multi-unit buildings and include a kitchen, a living area, a bathroom and a bedroom.  Costs may vary according to the location, size, community and subsidies by the government or paid privately. Residents are not supervised." )
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Co-operative Housing').first.update(desc: "Cooperative housing are housing units, which can range from an apartment building or complex to private housing. Each of the inhabitants or residents co own the cooperative and this could mean sharing of tax, resources, communal dining area, gardens, taxes and have financial benefits of co ownership. This model is becoming popular all over the world and is a trend now. Seniors can age in place and live in a community of all ages.")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Retirement Village').first.update(desc: "A village for retired seniors or seniors 55 years and older, covered by the Retirement Villages Act of 1986.  The seniors receive accommodation and services other than those provided in a residential care facility or aged care facility. This also includes that one of the residents as a contract paid an ingoing contribution that was not rent (lump sum or in installments) Popular in some continents.")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Hospice/palliative Care').first.update(desc: "A hospice house provides end of life / hospice care for people (seniors or younger) in a home like setting, with meals, dining, bed service, care as per needs. Here acute treatments can be administered, under the jurisdiction of a licensed physician trained in hospice care. Facility is licensed and regulated and must meet set standards and regulations. Residents who no longer need this service are transferred back to their homes with caregivers and under hospice care. The rooms are private or shared with an attached bathroom. Services not included in the original can be availed at an extra cost. Paid by private insurances, private pay, or government programs.")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Respite Care').first.update(desc: "Respite Care is short stay care for seniors with specific needs/ under hospice care, relieving their caregivers in order to prevent caregiver burnout or helping them cope with caregiving burdens (supporting) by making them avail some time off caring for themselves. They are usually at home. The facilities outside homes provide private or shared rooms with attached bathrooms, meals, social activities, medication assistance and even rehabilitation if available. Most are private pay and few insurances, do pay like Medicare if the patient is hospice (coverage for upto 5 days in the USA). The rates are variable and charged by care, days or weeks. Medicaid does not pay for respite care in the USA.
Examples of out of home respite care: Adult Day care centers, residential Respite care (senior living facilities and nursing homes).")
  ServiceType.where(available_for: 'senior_living').first.services.where(name: 'Multi-unit Housing').first.update(desc: "Multi Unit or mass housing rooms are usually very large rooms or buildings with an open floor plan, meals and laundry may not be available on site. They have common bathrooms. They do cater to people of all ages, who are independent. Usually private pay, costs may vary.")
end


