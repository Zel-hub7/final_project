class ReexamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reexam = Reexam.new
  end

  def create
    @reexam = current_user.student.reexams.build(reexam_params)
    if @reexam.save
      redirect_to student_reexams_path(current_user.student), notice: 'Re-exam application submitted successfully.'
    else
      render :new
    end
  end

  def index
    @reexams = current_user.student.reexams
  end

  private

  def reexam_params
    params.require(:reexam).permit(:status)
  end
end
