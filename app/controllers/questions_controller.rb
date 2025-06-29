class QuestionsController < ApplicationController
  QUESTIONS = YAML.load_file(Rails.root.join("config/questions.yml"))["questions"]

  def reset
    session[:answers] = nil

    if params[:to] == "top"
      redirect_to root_path
    else
      redirect_to question_step_path(1)
    end
  end

  def step
    step_num = params[:step].to_i

    if step_num < 1 || step_num > QUESTIONS.size || QUESTIONS[step_num].nil?
      logger.warn "[InvalidStepAccess] 無効なステップ: #{step_num}, IP: #{request.remote_ip}, session: #{session.inspect}"
      flash[:alert] = "無効なステップです"
      redirect_to root_path
      return
    end

    @question = QUESTIONS[step_num]
    @step = step_num
    @selected_answer = session[:answers]&.dig(@step.to_s)
    
    session[:shuffled_options] ||= {}
    session[:shuffled_options][@step.to_s] ||= @question["options"].to_a.shuffle
    @shuffled_options = session[:shuffled_options][@step.to_s]
  end

  def answer
    step = params[:step].to_i
    answer = params[:answer]

    unless step.between?(1, QUESTIONS.size)
      logger.warn "[InvalidAnswerStep] 不正なstep: #{step}, IP: #{request.remote_ip}, params: #{params.inspect}"
      flash[:alert] = "不正なステップが送信されました"
      redirect_to root_path
      return
    end

    if answer.blank?
      logger.info "[BlankAnswer] 回答が空でした。step: #{step}, IP: #{request.remote_ip}, session: #{session.inspect}"
      flash[:alert] = "選択肢を選んでください"
      redirect_to question_step_path(step)
      return
    end

    session[:answers] ||= {}
    session[:answers][step.to_s] = answer

    if step < QUESTIONS.size
      redirect_to question_step_path(step + 1)
    else
      score = session[:answers].values.tally
      category = score.max_by { |_k, v| v }&.first

      result = Result.find_by(category: category)

      if result
        redirect_to result_path(result.category)
      else
        logger.error "[ResultNotFound] category: #{category}, session: #{session.inspect}"
        flash[:alert] = "診断結果が見つかりませんでした"
        redirect_to root_path
      end
    end
  end
end
