class CollaboratorsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.build(user_id: params[:user_id])


    if collaborator.save
      flash[:notice] = "Added #{collaborator.user.email} as a collaborator."
    else
      flash[:alert] = "Failed."
    end

    redirect_to edit_wiki_path(wiki)
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.find_by(user_id: params[:user_id])


    if collaborator.destroy
      flash[:notice] = "Removed #{collaborator.user.email} as a collaborator."
    else
      flash[:alert] = "Failed."
    end

    redirect_to edit_wiki_path(wiki)
  end
end

private

def collab_params
  params.require(:collaborator).permit(:wiki_id, :user_id)
end
