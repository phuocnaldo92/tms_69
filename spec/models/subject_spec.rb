require "rails_helper"

RSpec.describe Subject, type: :model do

  let(:subject){FactoryGirl.create :subject}

  context "association" do
    it {is_expected.to have_many :exams}
    it {is_expected.to have_many :levels}
    it {is_expected.to have_many :suggest_questions}
  end

  context "validation" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:duration)}
  end

  describe ".seach" do
    it "returns a array of results" do
      subject1 = FactoryGirl.create(:subject, name: "subject1", duration: 20)
      subject2 = FactoryGirl.create(:subject, name: "subject2", duration: 20)
      expect(Subject.search("subject")).eql? [subject1, subject2]
    end
  end
end
