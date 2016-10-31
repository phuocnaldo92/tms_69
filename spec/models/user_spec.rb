require "rails_helper"

describe User do
  let!(:user) {FactoryGirl.create :user}

  subject {user}
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

    context "when email is not valid" do
      it "must not be blank" do
        subject.email = ""
        expect(subject).not_to be_valid
      end
    end

    context "when chatwork_id is not valid" do
      it "must not more than 50 characters" do
        subject.chatwork_id = Faker::Lorem.characters(55)
        expect(subject).not_to be_valid
      end
    end

    context "when password is not valid" do
      it "must not be blank" do
        subject.password = ""
        expect(subject).not_to be_valid
      end

      it "must not less than 6 characters" do
        subject.password ="fooba"
        expect(subject).not_to be_valid
      end
    end

    context "when password confirmation is not valid" do
      it "must not be blank" do
        subject.password_confirmation = ""
        expect(subject).not_to be_valid
      end

      it "must match password" do
        subject.password_confirmation = "foobar1"
        expect(subject).not_to be_valid
      end
    end
  end
end
