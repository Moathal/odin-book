class PostsController < ApplicationController
  before_action :set_post, only: %i[ show destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  # GET /posts/1 or /posts/1.json
  def index
    @posts = Post.all.map do |post|
            post.as_json.merge({
                text_html: post.text.to_s
            })
    end
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @user = @post.user
    @threads = @post.threads
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        PostNotifier.with(record: @post).deliver_later(PostNotifier.with(record: @post).new.recipients)
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:text, :user_id, :parent_id)
    end
end
