class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "curso de Ruby on Rails "
   @nome = params[ :nome]
   @curso = params[ :curso]
  end
  
end
