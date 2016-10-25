class Admin::SuggestQuestionsController < ApplicationController
  before_action :verify_admin
  before_action :load_all_levels, except: [:index, :destroy]
  before_action :load_suggest_question, except: [:index]

  def index
    @suggest_questions = SuggestQuestion.alphabet
      .page(params[:page]).per_page Settings.pagination.per_page
    @statuses = Question.statuses
  end

  def show
  end

  def edit
    @suggest_questions = SuggestQuestion.all
  end

  def update
    if @suggest_question.update_attributes suggest_question_params
      flash[:success] = t "flash.success.updated_contributed_question"
      redirect_to admin_suggest_questions_path
    else
      flash[:danger] = t "flash.danger.updated_contributed_question"
      load_all_levels
      render :edit
    end
  end

  def destroy
    if @suggest_question.destroy
      flash[:success] = t "flash.success.deleted_contributed_question"
    else
      flash[:danger] = t "flash.danger.deleted_contributed_question"
    end
    redirect_to admin_suggest_questions_path
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :content, :answer_type, :status,
      :level_id, suggest_answers_attributes: [:content, :is_correct,
      :_destroy, :suggest_question_id]
  end

  def load_all_levels
    @levels = Level.all
  end

  def load_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    unless @suggest_question
      flash.now[:danger] = t "flash.danger.question_not_found"
      redirect_to admin_suggest_questions_path
    end
  end
end
