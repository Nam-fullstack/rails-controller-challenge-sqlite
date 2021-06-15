# Rails Books App Controller Challenge

## Setup

1. Make a fork of this repo
2. Clone your fork to your local development environment
3. Install dependencies bundle install
4. Check node dependencies `yarn install --check-files`
5. run `rails s` and check that everything is working (you should see welcome to rails!)

## Challenge

### Core

1. Generate a books controller
2. Configure your `routes.rb` file, you're creating a full CRUD resource so you'll need routes to create, read, update and delete books, this will involve you using GET, POST, PUT and DELETE HTTP methods, to verify you've set your routes up correctly you can run `rails routes -c books`, it should look something like this

    ```
    Prefix Verb   URI Pattern          Controller#Action
    books  GET    /books(.:format)     books#index
           POST   /books(.:format)     books#create
    book   GET    /books/:id(.:format) books#show
           PUT    /books/:id(.:format) books#update
           DELETE /books/:id(.:format) books#destroy
    ```

3. Run the controller test to generate a `books.json` file, you can find this file in the public directory, all your tests should be failing at the moment

    ```
    bin/rspec spec/request/books_controller_spec.rb
    ```

4. In your `books_controller` implement a method to read in the data from the `books.json` file, you'll need to use `File.read` and `JSON.parse`, this method should be `private` to the controller, store the array of book hashes in an instance variable @books in this method
5. Use a `before_action` to run the method you created in step 4 before any controller action
6. Define an index method in your books_controller, send back @books to the client in JSON format, you can test this manually by running `rails s` opening a browser and making a request to our rails app using the url `http://localhost:3000/books`
7. Run the tests using the same command listed under step 3, the `GET #index` tests should now be green and passing
8. Define a show method in your books_controller, using `params` access the id sent through in the url and store it in a local variable, using the `.find` ruby array method find the book that has the same id as what's stored in the id we get via params, once you find this book send it back to the client in JSON format, you can test this manually by running `rails s` opening a browser and making a request to our rails app using the url `http://localhost:3000/books/1`, you should see this:

    ```json
    {
      "id": "1",
      "title": "Strangers on a Train",
      "author": "Patricia Highsmith"
    }
    ```

9. Run the tests using the same command listed under step 3, the `GET #show` tests should now be green and passing
10. We'll now be making POST, PUT and DELETE requests to our rails app, since we can't do this via the browser url bar we need to open the Postman app and make requests from there
11. Define a create method in your books_controller
12. In Postman make a POST request to `http://localhost:3000/books`, click on the preview button, we should be getting an InvalidAuthenticityToken error, how can we fix this? try googling `InvalidAuthenticityToken rails 6`
13. In Postman make a POST request to `http://localhost:3000/books` again, we should now see a 204 no content response, now send through some data in the query string of the POST request, we want to send through an id (of 4), title and author, [refer to this](https://en.wikipedia.org/wiki/Query_string#Structure) if you need help with the format of the query string
14. In the create action, make a book hash with the attributes sent through in the query string, push this hash into @books
15. In your `books_controller` implement a method to write data to the `books.json` file, you'll need to use `File.write` and `JSON.pretty_generate`, the method should take @books as a argument, this method should be `private` to the controller
16. Call this method after you've pushed the new book into @books and the redirect to the index method, you'll need to use the `redirect_to` method   
17. Run the tests using the same command listed under step 3, the `POST #create` tests should now be green and passing

### Advanced

18. Implement the update and destroy methods in the books controller, to confirm you've done this correctly run the tests using the command listed in step 3
19. We're currently passing in a hard coded id of "4" when we create a new book, how might we auto increment the id instead of passing it in as a query string

### Extra

20. One author can potentially have many books, instead of saving the author name in the book object lets store the name for the author in a separate JSON file, an `author_id` would then be stored in a book, for example:

    `authors.json`

    ```json
    [
      {
        "id": "1",
        "name": "Patricia Highsmith"
      }
    ]
    ```

    `books.json`

    ```json
    [
      {
        "id": "1",
        "title": "Strangers on a Train",
        "author_id": "1"
      },
      {
        "id": "2",
        "title": "The Talented Mr. Ripley",
        "author_id": "1"
      }
    ]
    ```

21. Add full CRUD for both authors and books, so you'd need to create a new `authors_controller` and edit the `routes.rb` file, you'll also need to change the way the routes work in the `books_controller` 
22. Create a [postman collection](https://learning.postman.com/docs/sending-requests/intro-to-collections/) to document and save the routes you've created
23. Add a route to search for an author and their books in the authors controller, use the [GoodReads API](https://www.goodreads.com/api/index#author.books), you'll need to sign up and get an API key, you'll need to firstly get an author id by author name, and then send through that author id in the query string to the author books route, use the [Faraday gem](https://lostisland.github.io/faraday/usage/) to make the API call

## Tests and Submitting

At any time you can run bin/rspec to see your progress, it will run the automated tests against your code and let you know what your progress is so far. Once you have all the tests passing, you can submit your challenge. To do this make sure you have committed your work:

1. From the project root `git add .` and add all the files changed in this folder
2. Commit these files to your repository `git commit -m "challenge completed"`
3. Make sure your working tree is clear git status
4. Push these files to your github repository git push origin master
5. Log on to Github and visit your fork of this challenge.
6. Make a pull request to the main branch.
7. Wait and watch the final tests run, if you are successful it will automatically let your educators know you are finished.