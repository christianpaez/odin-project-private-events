# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# faker gem
require 'faker'

UserEvent.destroy_all
User.destroy_all
Event.destroy_all

2.times do
    user = User.new(
        name: Faker::Name.name 
    )
    user.save

    # future events
    5.times do
        # user: creator
        event = user.events.build
        event.location = Faker::Address.full_address
        event.description = Faker::Lorem.sentence
        event.date = Faker::Date.between(from: '2020-08-01', to: '2020-08-30')
        event.save
    end

    #past events
    5.times do
        # user: creator
        event = user.events.build
        event.location = Faker::Address.full_address
        event.description = Faker::Lorem.sentence
        event.date = Faker::Date.between(from: '2020-06-01', to: '2020-06-30')
        event.save

        # add attendees to past event
        5.times do
            attende = User.create(
                name: Faker::Name.name 
            )
            UserEvent.create(
                user_id: attende.id,
                event_id: event.id
            )
        end
    end
    
end

# create users: attendes - for past events

# date = Date.parse("2020-06-05")
# start_date = date.at_beginning_of_month
# end_date = date.end_of_month
# past_event = Event.where(date: start_date..end_date).order("RANDOM()").first
# 3.times do
#     user = User.create(
#         name: Faker::Name.name 
#     )
#     UserEvent.create(
#         user_id: user.id,
#         event_id: past_event.id
#     )
# end

# create users: attendes - for future events

date = Date.parse("2020-08-05")
start_date = date.at_beginning_of_month
end_date = date.end_of_month
future_event = Event.where(date: start_date..end_date).order("RANDOM()").first
3.times do
    user = User.create(
        name: Faker::Name.name 
    )
    UserEvent.create(
        user_id: user.id,
        event_id: future_event.id
    )
end