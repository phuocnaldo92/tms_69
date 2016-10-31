require "rails_helper"

RSpec.describe Exam, type: :model do
  context "association" do
    it {is_expected.to belong_to :subject}
    it {is_expected.to belong_to :user}
    it {is_expected.to have_many :exam_questions}
  end

  describe "#set_default" do
    it "return status default is start" do
      exam = FactoryGirl.create :exam
      exam.set_default
      expect(exam.status).to eq "start"
    end
  end
end
