class WorksController < ApplicationController
  def index
    # @works = Work.all
    @works = Work.all
    @spotlight = Work.spotlight
    @movies = Work.top_ten("movie")
    @books = Work.top_ten("book")
    @albums = Work.top_ten("album")
    # @movies = Work.all.select {|work| work.category == "movie"}

    # @books = Work.all.select {|work| work.category == "book"}
    # @books.order(title: :desc)

    # @albums = Work.all.select {|work| work.category == "album"}
  end

  def show
    @result_work = Work.find(params[:id])
    @work_votes = Vote.where(work_id: params[:id])
  end

  def destroy
    work = Work.find(params[:id])
    category = work.category
    Work.destroy(params[:id])

    if category == "book"
      flash[:success] = "Successfully deleted book #{work.id}"
      redirect_to books_path
    elsif category == "album"
      flash[:success] = "Successfully deleted album #{work.id}"
      redirect_to albums_path
    elsif category == "movie"
      flash[:success] = "Successfully deleted movie #{work.id}"
      redirect_to movies_path
    else
      flash.now[:error] = "A problem occurred: Could not delete #{work.category}"
      render "show"
    end
  end

  def upvote
    @result_work = Work.find(params[:id])

    if session[:user_id] == nil
      flash[:error] = "you must be logged in to vote"
      redirect_to :back
      return
    end

    if session[:user_id]
        @vote = Vote.new
        @vote.user_id = session[:user_id]
        @vote.work_id = params[:id]
        if @vote.save
          flash[:success] = "Successfully upvoted!"
          # logger.info "===================Finished Upvoting an item #{@vote.errors.messages}"

          redirect_to :back
        else
          flash[:error] = "Could not upvote"
          flash[:error2] = "You already voted on this work"
          redirect_to :back
        end
    end

  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.title = work_params[:title]
    @work.creator = work_params[:creator]
    @work.description = work_params[:description]

    if @work.save
      redirect_to work_path(@work.id)
    # elsif @work.save && @work.category == "album"
    #   redirect_to albums_path
    # elsif @work.save && @work.category == "movie"
    #   redirect_to movies_path
    else
      render "edit"
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :creator, :description, :publication_year)
  end
end
