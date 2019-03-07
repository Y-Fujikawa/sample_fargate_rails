class HomeController < ApplicationController
  def index
    @count = Book.count
  end
end
