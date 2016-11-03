require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) {FactoryGirl.create(:user, role: :user)}
  let!(:admin) {FactoryGirl.create(:user, role: :admin)}
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

  describe "GET #show" do
    context "admin get Show successful" do
      it "has a 200 status code" do
        get :show, params: {id: user}
        expect(response.status).to eq(200)
        expect(response).to render_template("show")
      end
    end

    context "user get Show fail" do
      before do
        sign_in user
        get :show, params: {id: user}
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
        get :edit, params: {id: user}
        expect(response.status).to eq(200)
        expect(response).to render_template("edit")
      end
    end

    context "user get Edit fail" do
      before do
        sign_in user
        get :edit, params: {id: user}
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
        it "update a user and redirect to users path" do
          process :update, method: :put,
            params: {id: user, user: {name: "new name"}}
          user.reload
          expect(user.name).to eq ("new name")
          expect(response).to redirect_to admin_users_path
        end
      end

      context "with invalid attributes" do
        it "must not update a user and render edit" do
          process :update, method: :put,
            params: {id: user, user: {name: ""}}
          user.reload
          expect(user.name).not_to eq ("")
          expect(response).to render_template("edit")
        end
      end
    end

    context "user can't get Update" do
      before {sign_in user}
      it "must not update and redirect to root path" do
        process :update, method: :put,
          params: {id: user, user: {name: "new name"}}
        user.reload
        expect(user.name).not_to eq ("new name")
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #destroy" do
    context "admin get Destroy" do
      it "destroy a user successful" do
        expect {process :destroy, method: :delete,
          params: {id: user}}.to change(User, :count).by(-1)
      end

      it "redirect to admin users path after destroy successful" do
        process :destroy, method: :delete, params: {id: user}
        expect(response).to redirect_to admin_users_path
      end

      it "destroy a user fail" do
        user.destroy
        expect {process :destroy, method: :delete,
          params: {id: user}}.not_to change(User, :count)
      end

      it "redirect to admin users path after destroy fail" do
        user.destroy
        process :destroy, method: :delete, params: {id: user}
        expect(response).to redirect_to admin_users_path
      end
    end

    context "uset can't get Destroy" do
      before {sign_in user}
      it "must not destroy" do
        expect {process :destroy, method: :delete,
          params: {id: user}}.not_to change(User, :count)
      end

      it "must redirect to root path" do
        process :destroy, method: :delete, params: {id: user}
        expect(response).to redirect_to root_url
      end
    end
  end
end
