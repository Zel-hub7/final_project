module Admin
  class TestsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def create
      @student = Student.find(params[:student_id])
      @test = @student.tests.new(test_params)

      ActiveRecord::Base.transaction do
        if @test.save
          if @test.status == 'passed'
            @student.update!(session: 'completed')
          elsif @test.status == 'failed'
            @student.update!(session: 'failed_exam')
          end
          redirect_to admin_school_path(@student.school), notice: 'Test score was successfully added.'
        else
          redirect_to admin_school_path(@student.school), alert: 'Failed to add test score.'
        end
      end
    end

    private

    def authorize_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
    end

    def test_params
      params.require(:test).permit(:theory_exam, :practical_exam, :status)
    end
  end
end
