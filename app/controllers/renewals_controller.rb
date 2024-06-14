class RenewalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @renewal_request = RenewalRequest.new
  end

  def create
    @renewal_request = RenewalRequest.new(renewal_params)
    @renewal_request.student_id = current_user.id

    if @renewal_request.save
      redirect_to authenticated_root_path, notice: 'Renewal request submitted successfully.'
    else
      render :new, alert: 'Error submitting renewal request.'
    end
  end

  private

  def renewal_params
    params.require(:renewal_request).permit(:reason)
  end
end
