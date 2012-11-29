class Concert < ActiveRecord::Base
  attr_accessible :date, :full_desc, :name_art, :price,
   :song, :time_dur, :title, :user_id, :poster

  validates_presence_of :title, :date, :full_desc, :name_art, :user_id

  has_attached_file :poster#, :styles => { :medium => "400x400",
  	#:thumb => "140x140>" }

  belongs_to :user
end
