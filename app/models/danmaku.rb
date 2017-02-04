class Danmaku < ApplicationRecord
  Color = ['white','tomato' ,'orange', 'lightyellow','yellowgreen', 'dodgerblue', 'cyan', 'slateblue']

  validates :content, length: {maximum: 20,minimum: 1}
  validates :color, inclusion: Color
end
