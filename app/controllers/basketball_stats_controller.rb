class BasketballStatsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]


  def create

    @basketball_stat = current_user.basketball_stats.new(params[:basketball_stat])

    #We calculate the percentage of each type of field goal by dividing the total made by the total attempted
    # .nonzero? | 1 is used in order to avoid dividing by zero
    @basketball_stat.field_goal_percentage = @basketball_stat.field_goals_made.to_f/(@basketball_stat.field_goals_attempted.to_i.nonzero? || 10000)
    @basketball_stat.threept_percentage = @basketball_stat.threepts_made.to_f/(@basketball_stat.threepts_attempted.to_i.nonzero? || 10000)
    @basketball_stat.free_throw_percentage = @basketball_stat.free_throws_made.to_f/(@basketball_stat.free_throws_attempted.to_i.nonzero? || 10000)

    #The total points are calculated by multiplying the amount of fields goals made by the value of each type of field ( two-pointer, three-pointer, free throw)
    @basketball_stat.total_points = 1*@basketball_stat.free_throws_made.to_i + 2*@basketball_stat.field_goals_made.to_i + 3*@basketball_stat.threepts_made.to_i

    #The total rebounds are calculated by adding the defensive and offensive rebounds
    @basketball_stat.total_rebounds = @basketball_stat.offensive_rebounds.to_i + @basketball_stat.defensive_rebounds.to_i

    #Converts the minutes into seconds and assigns the total seconds played to the variable
    @basketball_stat.time_played_in_seconds = 60*@basketball_stat.minutes_played.to_i + @basketball_stat.seconds_played.to_i

    @basketball_stat.status = "Active"

    if @basketball_stat.save
      flash[:success] = "The stat was successfully added!"
      redirect_to user_path(current_user.id, tab:"Basketball")

    else
      flash[:error] = "We're sorry but we encountered an error while adding your stat."
      redirect_to user_path(current_user.id, tab:"Basketball")
    end

  end


  def destroy
    BasketballStat.find(params[:id]).update_attribute(:status, "deleted")

    redirect_to user_path(current_user.id, tab:"Basketball")
  end

end
