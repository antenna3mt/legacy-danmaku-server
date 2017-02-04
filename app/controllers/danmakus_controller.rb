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
    elsif (session[:time].nil?) or (Time.now.to_i - session[:time].to_i >= 10)
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
    else
      flash[:danger] = "Too Frequently"
      render 'danmakus/client'
    end
  end

  # Review Use
  def review
    if params[:car] == '911'

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
    render json: com  end

  def deny
    if params[:car] == '718'
      d = Danmaku.find(params[:id])
      d.status = 'denied'
      d.save!
    end
    render json: com
  end

  # Fetch Use
  def fetch
    if params[:car].equal? '918'
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
