class Admin::QuestionsController < ApplicationController
  before_action :verify_admin
  before_action :load_levels, except: [:index, :destroy]
  before_action :load_question, except: [:index, :new, :create]

  def index
    @questions = Question.newest.paginate page: params[:page],
      per_page: Settings.pagination.per_page
  end

  def show
  end

  def new
    @question = Question.new
    @question.answers.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash.now[:success] = t "flash.success.created_question"
      redirect_to admin_questions_path
    else
      flash.now[:danger] = t "flash.danger.created_question"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.danger.edit_question"
      redirect_to admin_questions_path
    else
      flash[:danger] = t "flash.danger.edit_question"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash.now[:success] = t "flash.success.deleted_question"
    else
      flash[:danger] = t "flash.danger.deleted_question"
    end
    redirect_to :back
  end

  private
  def load_levels
    @levels = Level.all
  end

  def load_question
    @question = Question.includes(level: :subject).find_by id: params[:id]
    unless @question
      flash.now[:danger] = t "flash.danger.question_not_found"
      redirect_to admin_questions_path
    end
  end

  def question_params
    params.require(:question).permit :content, :answer_type, :level_id,
      answers_attributes: [:content, :is_correct, :question_id]
  end
end
