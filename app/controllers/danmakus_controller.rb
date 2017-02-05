class DanmakusController < ApplicationController

  # General Use
  def check
    render xml: com
  end

  # CLient Use
  def client
  end

  def create
    @content = params['content']
    @color = params['color']
    if not checkRecaptcha(params["g-recaptcha-response"])
      flash[:danger] = 'Robot Check Failed'
      render 'danmakus/client'
    else
      session[:time] = Time.now.to_i
      d = Danmaku.new(content: @content, color: @color, status: 'raw')
      if d.save
        @content = ""
        flash[:success] = "Successfully"
        redirect_to client_path
      else
        d.errors.full_messages.each do |error|
          flash[:danger] = error
          render 'danmakus/client'
        end
      end
    end
  end

  # Review Use
  def review
    if params[:car] == '900'
      @danmakus = Danmaku.where(status: 'raw')
    elsif params[:car] == '917'
      @danmakus = Danmaku.all
    else
      render json: com
    end
  end

  def approve
    if params[:car] == '718'
      d = Danmaku.find(params[:id])
      d.status = 'approved'
      d.save!
    end
    redirect_to review_path(car: '900')
  end

  def deny
    if params[:car] == '718'
      d = Danmaku.find(params[:id])
      d.status = 'denied'
      d.save!
    end
    redirect_to review_path(car: '900')
  end

  # Fetch Use
  def fetch
    if params[:car]== '918'
      @danmakus = Danmaku.where(status: 'approved')
      @danmakus.each do |danmaku|
        danmaku.status = "displayed"
        danmaku.save!
      end
      render json: @danmakus
    else
      render json: []
    end

  end

  private
  def com
    re = Hash.new
    re['success'] = true
    return re
  end


  def checkRecaptcha(responce)
    params = {
        'secret' => '6Ld5OBgTAAAAAP9fcR4SwHcaoOV1lQFlE7hFYX-2',
        'response' => responce
    }
    x = Net::HTTP.post_form(URI.parse('https://www.google.com/recaptcha/api/siteverify'), params)
    return JSON.parse(x.body)['success']
  end
end
