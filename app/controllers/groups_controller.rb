class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit join update destroy]

  # GET /groups or /groups.json
  def index
    @groups = index_filtered.preload(:group_members).order(id: :desc)
  end

  # GET /groups/1 or /groups/1.json
  def show; end

  # POST /groups/join/1 or /groups/join/1.json
  def join
    if current_user.blank?
      render json: { code: 'UNAUTHORIZED', message: 'You are not authorized' }, status: :unauthorized
      return
    end
    if @group.creator == current_user
      render json: { code: 'ACTION_NOT_ALLOWED', message: 'Joining own group not allowed' }, status: :forbidden
      return
    end
    @group.group_members.create member: current_user
  rescue StandardError => _e
    render json: { code: 'INTERNAL_SERVER_ERROR', message: 'An internal server error happened. Please retry later' },
           status: :internal_server_error
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id] || params[:group_id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name).merge creator: current_user
  end

  def index_filtered
    case params[:filter_by]
    when 'creator_me'
      current_user.groups
    when 'member_me'
      current_user.groups_member_me
    else
      Group
    end
  end
end
