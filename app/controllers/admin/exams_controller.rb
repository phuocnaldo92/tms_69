class Admin::ExamsController < ApplicationController
  before_action :load_exam, only: [:show, :update]

  def index
    @exams = Exam.newest.page(params[:page])
      .per_page Settings.pagination.per_page
  end

  def show
  end

  def update
    if @exam.update_attributes exam_params
      @exam.update_status params[:checked]
      flash[:success] = t "flash.success.checked_exam"
    else
      flash[:danger] = t "flash.danger.checked_exam"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      exam_questions_attributes: [:id, :is_correct]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    unless @exam
      flash[:danger] = t "flash.danger.exam_not_found"
      redirect_to admin_root_path
    end
  end
end
