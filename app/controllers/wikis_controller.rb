class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :user_is_admin_or_wiki_owner?, only: :destroy
  before_action :user_is_authorized_for_private_wikis?, only: :show
  require 'redcarpet/compat'

  def index
    @wikis = Wiki.all
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
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
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
     unless wiki.private == false || current_user && (current_user.premium? || current_user.admin?)
       flash[:alert] = "You are unauthorized to see private wikis."
       redirect_to wikis_path
     end
  end
end
