class CommentsController < ApplicationController

  before_filter :users_comment, except: ["create"]
  before_filter :valid_user, only: ["create"]

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to content_path, notice: 'Successfully commentted.' }
      else
        format.html { redirect_to content_path, flash: {error: 'Comment could not be created.'}}
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to content_path, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to content_path, notice: "Successfully deleted comment."}
    end
  end

  private

    def users_comment
      redirect_to content_path, flash: {error: "That's not yours!"} unless Comment.find(params[:id]).user.id == current_user.id
    end


    def valid_user
      redirect_to content_path, flash: {error: "You can't do that!"} unless current_user.id == params[:comment][:user_id].to_i
    end
end
