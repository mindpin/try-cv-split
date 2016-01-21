class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # 初级的分离方案中
  # 类似 index show new edit 等 GET 请求 action
  # 没有做到分离
  # 彻底分离时应该只 render json
  # 由 js 构建页面 dom 内容

  def index
    @books = Book.all
  end


  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  # 类似 create update destory 等非 GET 请求 action
  # 只 render json
  # 所有页面跳转，错误回报，页面内容变更都由 js 处理

  def create
    @book = Book.new(book_params)
    # 做一些和 current_user，设备，请求头信息 …… 等相关的事情
    _do_save @book
  end

  def update
    @book.assign_attributes(book_params)
    # 做一些和 current_user，设备，请求头信息 …… 等相关的事情
    _do_save @book
  end

  def destroy
    @book.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :body, :published)
    end
end
