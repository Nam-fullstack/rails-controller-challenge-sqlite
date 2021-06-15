require 'rails_helper'

RSpec.describe "Books", type: :request do
  before(:each) do
    @books = [
      {
        "id": "1",
        "title": "Strangers on a Train",
        "author": "Patricia Highsmith"
      },
      {
        "id": "2",
        "title": "The Great Gatsby",
        "author": "F. Scott Fitzgerald"
      },
      {
        "id": "3",
        "title": "Goodbye to Berlin",
        "author": "Christopher Isherwood"
      }
    ]
    File.write(Rails.public_path.join('books.json'), JSON.pretty_generate(@books))
  end

  context 'GET #index' do
    before(:example) do
      get '/books'
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response contains the correct number of books' do
      expect(@json_response.length).to eq(3)
    end

    it 'response contains the correct entries' do
      expect(@json_response.first).to include(
        {
          'id' => '1',
          'title' => 'Strangers on a Train',
          'author' => 'Patricia Highsmith'
        }
      )
    end
  end

  context 'GET #show' do
    before(:example) do
      get "/books/1"
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response contains the correct entry' do
      expect(@json_response).to eq(
        {
          'id' => '1',
          'title' => 'Strangers on a Train',
          'author' => 'Patricia Highsmith'
        }
      )
    end
  end

  context 'POST #create' do
    before(:example) do
      @new_book = {
        'id' => '4',
        'title' => 'Test Book',
        'author' => 'JK Rowling'
      }
      post '/books', params: @new_book
    end
    
    it 'Redirects to /books after creating a new book' do
      expect(response).to redirect_to(books_path)
    end
    
    it 'Saves the book to the file' do
      expect(read_books_file.last['title']).to eq(@new_book['title'])
    end
  end

  context 'PUT #update' do
    before(:example) do
      @updated_book = {
        'title' => 'Effective Testing with RSpec 3',
        'author' => 'Myron Marston and Ian Dees'
      }
      put '/books/1', params: @updated_book
    end

    it 'Redirects to /books after updating a book' do
      expect(response).to redirect_to(books_path)
    end

    it 'Edits the correct book and saves it to the file' do
      expect(read_books_file.first['title']).to eq(@updated_book['title'])
    end
  end

  context 'DELETE #destroy' do
    before(:context) do
      @second_book = read_books_file[1]
    end

    before(:example) do
      delete '/books/1'
    end

    it 'Redirects to /books after deleting a book' do
      expect(response).to redirect_to(books_path)
    end

    it 'Deletes the correct book' do
      expect(read_books_file.first['title']).to eq(@second_book["title"])
    end
  end
  
  context "POST #create" do 
    before(:example) do
      @new_book = {
        'title' => 'Test Book',
        'author' => 'JK Rowling'
      }
      post '/books', params: @new_book
    end

    it 'auto increments id' do 
      expect(read_books_file.last['id']).to eq('4')
    end
  end

  private

  def read_books_file
    JSON.parse(File.read(Rails.public_path.join('books.json')))
  end
end
