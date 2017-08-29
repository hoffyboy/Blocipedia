class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :user_is_admin_or_wiki_owner?, only: :destroy
  before_action :user_is_authorized_for_private_wikis?, only: [:show, :edit]
  require 'redcarpet/compat'

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    if @wiki.save
      flash.now[:notice] = "Wiki was updated."
      respond_to do |format|
        format.js { render layout: false }
        format.html { redirect_to @wiki }
      end
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def user_is_admin_or_wiki_owner?
    wiki = Wiki.find(params[:id])

    unless current_user.admin? || current_user == wiki.user
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end

   def user_is_authorized_for_private_wikis?
    wiki = Wiki.find(params[:id])
    unless (wiki.private == false ||
    current_user.try(:admin?) ||
    wiki.collaborators.find_by(user_id: current_user.try(:id)) ||
    current_user == wiki.user)
      flash[:alert] = "You are unauthorized to see private wikis."
      redirect_to wikis_path
    end
  end
end
