class ExamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_exam, only: [:show, :update]

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = current_user.exams.includes(:subject, :exam_questions).newest
      .paginate page: params[:page], per_page: Settings.pagination.per_page
  end

  def show
    @exam.update_status
    @exam.exam_questions.each do |exam_question|
      exam_question.build_exam_answers
    end
  end

  def create
    @exam = current_user.exams.new exam_params_create
    if @exam.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "flash.danger.created_exam"
      redirect_to exams_path
    end
  end

  def update
    if @exam.update_attributes exam_params
      @exam.update_status params[:finish]
      flash[:success] = t "flash.success.saved_exam"
    else
      flash[:danger] = t "flash.danger.saved_exam"
    end
    redirect_to exams_path
  end

  private
  def exam_params_create
    params.require(:exam).permit :subject_id
  end
  def exam_params
    params.require(:exam).permit exam_questions_attributes: [:id,
      exam_answers_attributes: [:id, :answer_id, :content, :_destroy]]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = t "flash.danger.exam_not_found"
      redirect_to admin_root_path
    end
  end
end
