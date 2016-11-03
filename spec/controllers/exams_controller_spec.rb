require "rails_helper"
require "database_cleaner"

RSpec.describe ExamsController, type: :controller do
  before do
    @subject = FactoryGirl.create(:subject, name: "Toan", duration: 20)
    @user = FactoryGirl.create(:user, name: "Nhat")
    sign_in @user
  end

  describe "GET #index" do
    it "assigns a new Exams to @exam" do
      get :index
      expect(assigns(:exam)).to be_a_new Exam
    end

    it "assigns all Subject to @subject" do
      get :index
      subjects = Subject.all
      expect(assigns(:subjects)).to eq subjects
    end

    it "assigns all Exam to @exam" do
      get :index
      exams = @user.exams
      expect(assigns(:exams)).to eq exams
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    let(:current_user)do
      FactoryGirl.create(:user)
    end

    context "with valid attributes" do
      it "saves the new exam in the database" do
        expect{
          process :create, method: :post, params: {exam: attributes_for(:exam,
            subject_id: @subject.id)}, format: :js
        }.to change(Exam, :count).by 1
      end

      it "renders the :create template" do
        process :create, method: :post, params: {exam: attributes_for(:exam,
        subject_id: @subject.id)}, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe "GET #show" do
    before do
      @exam = FactoryGirl.create(:exam, subject: @subject, user: @user)
    end

    it "assigns the requested exam to @exam" do
      get :show, params: {id: @exam}
      expect(assigns(:exam)).to eq @exam
    end

    it "renders the :show template" do
      exam = create(:exam)
      get :show, params: {id: exam}
      expect(response).to render_template :show
    end
  end
end
