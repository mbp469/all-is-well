class TherapistsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :index]
  def index
    client_login_redirect

    sort_by = params[:sort_by]
    if current_user.userable_type == "Therapist"
      @therapist = Therapist.find(current_user.userable.id)
      @clients = Client.where(therapist_id: @therapist.id)
    elsif current_user.userable_type == "Client"
      @client = Client.find(current_user.userable.id)
      @therapist = Therapist.find(@client.therapist_id)
    else
      redirect_to root_path
    end
    unless sort_by.nil?
      @clients = @clients.order(sort_by => :asc)
    end
  end

  #page that shows 4 option link to clients stuff T-client page
  def show
  end

  def update
    @therapist = current_user.userable
    @therapist.update therapist_params
    redirect_to t_profile_path
  end

  def t_profile
    @therapist = Therapist.find(current_user.userable.id)
    @therapist_name = @therapist.first_name + " " + @therapist.last_name
  end

  def new
    @therapist = Therapist.new therapist_params
    if @therapist.save
      @user = User.new user_params
      @user.email = @therapist.email
      @user.userable = @therapist
      @user.save
      sign_in @user # some devise thing
      render :index
    else
      render :new
    end
  end

  def calendar
    @events = Event.where(client_id: params[:id])
    current_client
  end

  def c_profile
    current_client
  end

  def activity
    current_client
    @entries = Post.where(client_id: params[:id])
    @events = Event.where(client_id: params[:id])
    @surveys = Survey.where(client_id: params[:id])
    @user = current_user
  end

  def render_events
    current_client
    events = Event.where(client_id: @current_client.id)
    render :json => events
  end

  def note
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def therapist_params
    params.require(:therapist).permit(:first_name, :last_name, :cred, :phone, :email)
  end

end
