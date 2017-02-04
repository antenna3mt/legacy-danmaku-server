Rails.application.routes.draw do
  root 'danmakus#client'

  # General Use
  get 'check' => 'danmakus#check'

  # Client Use
  get '' => 'danmakus#client', as: 'client'
  post '' => 'danmakus#create', as: 'create'

  # Review Use
  get 'review' => 'danmakus#review', as: 'review'
  get 'approve/:id' => 'danmakus#approve', as: 'approve'
  get 'deny/:id' => 'danmakus#deny', as: 'deny'

  get 'fetch' => 'danmakus#fetch'
  get 'update/:id/:status' => 'danmakus#update'
end
