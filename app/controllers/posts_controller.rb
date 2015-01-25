class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    set_post
  end

  def new
    @post = Post.new
  end

  def edit
    set_post
  end

  def create
    @post = Post.new(post_params)

    @post.save
    redirect_to @post
  end

  def update
    set_post

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @post }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
