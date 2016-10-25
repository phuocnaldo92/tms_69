class SuggestQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_all_subject, except: [:index, :destroy]
  before_action :load_suggest_question, except: [:index, :new, :create]

  def index
    @suggest_questions = current_user.suggest_questions.alphabet
      .page(params[:page]).per_page Settings.pagination.per_page
  end

  def new
    @suggest_question = current_user.suggest_questions.new
    @suggest_question.suggest_answers.new
  end

  def show
  end

  def create
    @suggest_question = current_user.suggest_questions.new
      suggest_question_params
    if @suggest_question.save
      flash[:success] = t "flash.success.contributed_question"
      redirect_to suggest_questions_path
    else
      flash[:danger] = t "flash.danger.contributed_question"
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest_question.update_attributes suggest_question_params
      flash[:success] = t "flash.success.updated_contributed_question"
      redirect_to suggest_questions_path
    else
      flash[:danger] = t "flash.danger.updated_contributed_question"
      load_all_subject
      render :edit
    end
  end

  def destroy
    if @suggest_question.destroy
      flash[:success] = t "flash.success.deleted_contributed_question"
    else
      flash[:danger] = t "flash.danger.deleted_contributed_question"
    end
    redirect_to suggest_questions_path
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :content, :answer_type,
      :subject_id, suggest_answers_attributes: [:content, :is_correct,
        :_destroy, :suggest_question_id]
  end

  def load_all_subject
    @subjects =  Subject.all
  end

  def load_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    unless @suggest_question
      flash.now[:danger] = t "flash.danger.question_not_found"
      redirect_to suggest_questions_path
    end
  end
end
