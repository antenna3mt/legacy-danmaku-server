class DanmakusController < ApplicationController
  def client

  end

  def create

  end

  def review

  end


  def fetch

  end

  def update

  end

  def check
    output = com
    render json: output
  end


  private
  def com
    re = Hash.new
    re['success'] = true
    return  re
  end
end
