class TasksController < ApplicationController
  before_action :set_task, only: %i[ ide show edit update destroy submit ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.to_a
    submissions_cache = Submission.where(result: "success", student_id: Current.user.student, task_id: @tasks.map(&:id))
    @tasks.map! do |task|
      {
        task: task,
        completed: submissions_cache.find{it.task_id == task.id}.present?
      }
    end

    due = @tasks.select { it[:task].due_date < Time.now || it[:completed]}.sort{it[:task].due_date <=> it[:task].due_date}.reverse
    not_due = @tasks.select { it[:task].due_date > Time.now }.sort{it[:task].due_date <=> it[:task].due_date}
    not_due -= due

    @tasks = not_due + due
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # POST /tasks/1/ide/submit
  def submit
    ProcessSubmissionJob.perform_later(
      task_id: @task.id,
      student_id: Current.user.student.id,
      code: params[:submission_code]
    )

    render json: {lol: 2}
  end

  # GET /tasks/1/ide
  def ide
    headers[:borderless] = true
    submissions = Submission
      .where(task: @task, student: Current.user.student)
      .eager_load(:corrections)
      .order(created_at: :desc)

    render Tasks::IdeView.new(task: @task, submissions:)
  end

  # GET /tasks/new
  def new
    render Tasks::NewView.new(Task.new(challenge_id: params[:challenge_id]))
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.room = Current.user.selected_room

    respond_to do |format|
      if @task.save
        format.html { redirect_to challenges_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render Tasks::NewView.new(@task), status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :challenge_id, :due_date ])
    end
end
