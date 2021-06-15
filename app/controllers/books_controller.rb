class BooksController < ApplicationController
  before_action :read_json
  skip_before_action :verify_authenticity_token

  def index
    render :json => @books
  end

  def show
    display_book = @books.find { |book| book["id"] == params[:id] }
    render :json => display_book
  end

  def create
    @books.push(
        { 
        "id" => (@books.length+1).to_s,
        "title" => params[:title],
        "author" => params[:author] 
        }
    )
    write_json(@books)
    redirect_to "/books"
  end

  def update
    index_number = @books.index { |book| book["id"] == params[:id] }
    @books[index_number]["author"] = params[:author]
    @books[index_number]["title"] = params[:title]
    write_json(@books)
    redirect_to "/books"
  end

  def destroy
    @books.delete_if { |book| book["id"] == params[:id] }
    write_json(@books)
    redirect_to "/books"
  end
  
  private
  
  def read_json
    @books = JSON.parse(File.read(Rails.public_path.join("books.json")))
  end

  def write_json(books)
    File.write(Rails.public_path.join("books.json"), JSON.pretty_generate(@books))
  end
end
