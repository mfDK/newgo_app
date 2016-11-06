require 'rails_helper'

RSpec.describe Goal, :type => :model do
	let(:full_goal) { 
		Goal.create(
			title: "RSpec for Goals", 
			description: "This is the description",
			end_date: "2016-11-16 00:00:00",
			completed_at: "016-11-06 02:47:31"
			)
		}

	let(:blank_goal) {
		Goal.create(
			title: "",
			description: "",
			end_date: nil,
			completed_at: nil
		)
	}

	let(:long_goal) {
		Goal.create(
			title: "This title is way too long, should not be more than 30 characters long",
			description: "This description is way too long and shot not be more than 140 characters like twitter, I have to keep writing because I not sure how long this description 			I'm writing is until I use the .length method haha."
		)
	}

	it "creates a goal record" do
		expect(full_goal.title).to eq("RSpec for Goals")
	end

	it "is blank" do
		expect(blank_goal.title.empty?).to eq(true)
	end

	it "title is too short" do
		expect(blank_goal.title.length < 7).to eq(true)
	end

	it "title is too long" do 
		expect(long_goal.title.length > 30).to eq(true)
	end

	it "description is blank" do
		expect(blank_goal.description.empty?).to eq(true)
	end

	it "description is too long" do
		expect(long_goal.description.length > 140).to eq(true)
	end

	it "end date is nil" do
		expect(full_goal.end_date).to eq(full_goal.end_date)
	end

	it "has no tasks" do
		expect(full_goal.tasks.count).to eq(0)
	end



end