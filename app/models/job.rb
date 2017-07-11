class Job < ApplicationRecord


  validates :title , presence: {message: "请填写标题"}
  validates :wage_upper_bound, presence: {message:"请填写最高薪水"}
  validates :wage_lower_bound, presence: {message:"请填写最低薪水"}
  validates :wage_lower_bound, numericality: { greater_than: 0, message: "最低薪水必须大于0"}

  validates :wage_lower_bound, numericality: {less_than: :wage_upper_bound, message: "薪水下限不能高于薪水上限"}

  has_many :resumes

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }

end
