# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.first
u.testimonials.create({highlight: "Thank You", body: "Words cannot express how grateful we are for all your hard work during our wedding planning. Your professionalism dealing with our frequent questions always put us at ease in a stressful time. You made things simple & easy to understand for us and our guests. Our only wish was that you could have joined us at this beautiful resort. Thank you again for helping to create memories that will last a lifetime.", signature: "Nate and Trish", display: true, position: 0})

u.testimonials.create({highlight: "We had a wonderful time", body: "Our recent cruise aboard the Caribbean Princess was perfect in every way. The luxury of the ship, beauty of the beaches and scenery of the islands can only be described as breathtaking. Our gratitude for your service, recommendations and advice cannot be overstated. Your thoughtful gifts that awaited us in our stateroom were deeply appreciated. Thank you so much. We had a wonderful time and, it would be a safe bet to say that we will be cruising again.", signature: "Al & Karen Jurgensen
", display: true, position: 1})