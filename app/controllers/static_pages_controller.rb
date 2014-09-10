class StaticPagesController < ApplicationController
  def root
    render :root
  end
  
  def resources
    render :resources
  end
end
