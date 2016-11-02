require "rails_helper"

RSpec.describe Admin::SubjectsController, type: :controller do
  let!(:user) {FactoryGirl.create(:user, role: :user)}
  let!(:admin) {FactoryGirl.create(:user, role: :admin)}
  let!(:subject) {FactoryGirl.create(:subject)}
  before {sign_in admin}

  describe "GET #index" do
    context "admin get Index successful" do
      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template("index")
      end
    end

    context "user get Index fail" do
      before do
        sign_in user
        get :index
      end
      it "has a 302 status code" do
        expect(response.status).to eq(302)
        expect(response).not_to render_template("index")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #new" do
    context "admin get New successful" do
      it "has a 200 status code" do
        get :new
        expect(response.status).to eq(200)
        expect(response).to render_template("new")
      end
    end

    context "user get New fail" do
      before do
        sign_in user
        get :new
      end
      it "has a 302 status code" do
        expect(response.status).to eq(302)
        expect(response).not_to render_template("new")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #create" do
    context "admin get Create" do
      context "with valid attributes" do
        it "create a new subject" do
          expect {process :create, method: :post,
            params: {subject: FactoryGirl.attributes_for(:subject)}}.
            to change(Subject, :count).by(1)
        end

        it "redirect to subjects path" do
          process :create, method: :post,
            params: {subject: FactoryGirl.attributes_for(:subject)}
          expect(response).to redirect_to admin_subjects_path
        end
      end

      context "with invalid attributes" do
        it "must not create a new subject" do
          expect {process :create, method: :post,
            params: {subject: FactoryGirl.attributes_for(:subject, name: nil)}}.
            not_to change(Subject, :count)
        end

        it "must render New" do
          process :create, method: :post,
            params: {subject: FactoryGirl.attributes_for(:subject, name: nil)}
          expect(response).to render_template("new")
        end
      end
    end

    context "user can't get Create" do
      before {sign_in user}
      it "must not create a new subject" do
        expect {process :create, method: :post,
          params: {subject: FactoryGirl.attributes_for(:subject)}}.
          not_to change(Subject, :count)
      end

      it "redirect to root path" do
        process :create, method: :post,
          params: {subject: FactoryGirl.attributes_for(:subject)}
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #show" do
    context "admin get Show successful" do
      it "has a 200 status code" do
        get :show, params: {id: subject}
        expect(response.status).to eq(200)
        expect(response).to render_template("show")
      end
    end

    context "user get Show fail" do
      before do
        sign_in user
        get :show, params: {id: subject}
      end
      it "has a 302 status code" do
        expect(response.status).to eq(302)
        expect(response).not_to render_template("show")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #edit" do
    context "admin get Edit successful" do
      it "has a 200 status code" do
        get :edit, params: {id: subject}
        expect(response.status).to eq(200)
        expect(response).to render_template("edit")
      end
    end

    context "user get Edit fail" do
      before do
        sign_in user
        get :edit, params: {id: subject}
      end
      it "has a 302 status code" do
        expect(response.status).to eq(302)
        expect(response).not_to render_template("edit")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #update" do
    context "admin get Update" do
      context "with valid attributes" do
        it "update a subject and redirect to subjects path" do
          process :update, method: :put,
            params: {id: subject, subject: {name: "new name"}}
          subject.reload
          expect(subject.name).to eq ("new name")
          expect(response).to redirect_to admin_subjects_path
        end
      end

      context "with invalid attributes" do
        it "must not update a subject and render edit" do
          process :update, method: :put,
            params: {id: subject, subject: {name: ""}}
          subject.reload
          expect(subject.name).not_to eq ("")
          expect(response).to render_template("edit")
        end
      end
    end

    context "user can't get Update" do
      before {sign_in user}
      it "must not update and redirect to root path" do
        process :update, method: :put,
          params: {id: subject, subject: {name: "new name"}}
        subject.reload
        expect(subject.name).not_to eq ("new name")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #destroy" do
    context "admin get Destroy" do
      it "destroy a subject successful" do
        expect {process :destroy, method: :delete,
          params: {id: subject}}.to change(Subject, :count).by(-1)
      end

      it "redirect to admin subjects path after destroy successful" do
        process :destroy, method: :delete, params: {id: subject}
        expect(response).to redirect_to admin_subjects_path
      end

      it "destroy a subject fail" do
        subject.destroy
        expect {process :destroy, method: :delete,
          params: {id: subject}}.not_to change(Subject, :count)
      end

      it "redirect to admin subjects path after destroy fail" do
        subject.destroy
        process :destroy, method: :delete, params: {id: subject}
        expect(response).to redirect_to admin_subjects_path
      end
    end

    context "uset can't get Destroy" do
      before {sign_in user}
      it "must not destroy" do
        expect {process :destroy, method: :delete,
          params: {id: subject}}.not_to change(Subject, :count)
      end

      it "must redirect to root path" do
        process :destroy, method: :delete, params: {id: subject}
        expect(response).to redirect_to root_url
      end
    end
  end
end
