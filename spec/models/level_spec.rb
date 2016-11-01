require "rails_helper"

describe Level do
  let!(:level) {FactoryGirl.create :level}

  subject {level}

  context "validation" do

    context "when name is not valid" do
      it "must not be blank" do
        subject.name = ""
        expect(subject).not_to be_valid
      end

      it "must not more than 50 characters" do
        subject.name = Faker::Lorem.characters(55)
        expect(subject).not_to be_valid
      end
    end

    context "when question number is not valid" do
      it "must not be blank" do
        subject.question_number = ""
        expect(subject).not_to be_valid
      end

      it "must be a number" do
        subject.question_number = Faker::Lorem.characters(2)
        expect(subject).not_to be_valid
      end

      it "must not less than 0" do
        subject.question_number = -1
        expect(subject).not_to be_valid
      end

      it "must not be greater than 99" do
        subject.question_number = Faker::Number.number(3)
        expect(subject).not_to be_valid
      end
    end
  end
end
