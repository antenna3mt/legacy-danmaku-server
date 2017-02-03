Rails.application.routes.draw do
  root 'danmakus#client'


  get 'check' => 'danmakus#check'
end
