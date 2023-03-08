class User < ApplicationRecord
  has_many :books, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  validates :name, presence: true, uniqueness: true,length:{minimum: 2, maximum: 20 }
  validates :introduction, length:{maximum:50}

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     image.variant(resize_to_limit: [100,100]).processed
  end


end
