class OutlookController < ApplicationController
  before_action :set_teams_and_project_managers, only: [:index]

  def index
    @interval = [3.months.ago.beginning_of_month.to_date,
                 1.year.from_now.end_of_month.to_date]
    @range_of_months = range_of_months(@interval)
    @projects = Project.order(:name).
      where.not(start_date: nil, end_date: nil).
      filter_with(index_filters).
      includes([:milestones, :invoices, :project_manager, :team]).live
  end


  private

  def range_of_months interval
    start_date, end_date = interval
    range = []
    (start_date.year..end_date.year).each do |y|
      mo_start = (start_date.year == y) ? start_date.month : 1
      mo_end = (end_date.year == y) ? end_date.month : 12

      (mo_start..mo_end).each do |m|
        range << Date.parse("#{m}/#{y}")
      end
    end
    range
  end

  def index_filters
    params.permit(:team_id, :project_manager_id)
  end

  def set_teams_and_project_managers
    @teams = Team.active.order(:name)
    @project_managers = User.project_managers
  end
end
