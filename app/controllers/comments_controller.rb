class CommentsController < ApplicationController
  before_action :set_book, only: [:new, :create, :index]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # 初级的分离方案中
  # 类似 index show new edit 等 GET 请求 action
  # 没有做到分离
  # 彻底分离时应该只 render json
  # 由 js 构建页面 dom 内容

  def index
    @comments = Comment.all
    render json: @comments
  end


  def show
  end

  def new
    @comment = @book.comments.new
  end

  def edit
  end

  # 类似 create update destory 等非 GET 请求 action
  # 只 render json
  # 所有页面跳转，错误回报，页面内容变更都由 js 处理

  def create
    @comment = @book.comments.new(comment_params)
    # 做一些和 current_user，设备，请求头信息 …… 等相关的事情
    _do_save @comment
  end

  def update
    @comment.assign_attributes(comment_params)
    # 做一些和 current_user，设备，请求头信息 …… 等相关的事情
    _do_save @comment
  end

  def destroy
    @comment.destroy
    render json: {}
  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
