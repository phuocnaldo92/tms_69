class Admin::SubjectsController < ApplicationController
  before_action :load_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def new
    @subject = Subject.new
  end

  def show
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "flash.susscess.create_subject"
      redirect_to admin_subjects_path
    else
      flash[:danger] = "flash.danger.created_subject"
      render :new
    end
  end

  private
    def subject_params
      params.require(:subject).permit :name, :question_number, :duration
    end

    def load_subject
      @subject = Subject.find_by id: params[:id]
      unless @subject
        flash.now[:danger] = t "flash.danger.subject_not_found"
        redirect_to admin_subjects_path
      end
    end
end
