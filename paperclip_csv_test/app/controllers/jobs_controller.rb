class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs/confirm
  def confirm
    @job = Job.new(job_params)
    @job.tempfile_path = job_params[:csv].path
    if @job.valid?
      render :confirm
    else
      render :new
    end
  end

  # POST /jobs
  # POST /jobs.json
  def create
    upload_file = ActionDispatch::Http::UploadedFile.new(
      filename: job_params[:csv_file_name],
      type: 'text/csv',
      tempfile: File.open(job_params[:tempfile_path])
    )

    @job = Job.new(job_params.merge(csv: upload_file))

    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      redirect_to :new, notice: 'Failed.'
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:name, :priority, :csv, :tempfile_path, :csv_file_name)
    end
end
