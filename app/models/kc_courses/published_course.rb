module KcCourses
  class PublishedCourse
    include Mongoid::Document
    include Mongoid::Timestamps

    field :enabled, type: Boolean, default: false # 是否启用，取 true 或 false
    field :data # 把课程的结构数据整个怼进去
    belongs_to :course, class_name: 'KcCourses::Course' # 方便找到对应的原始数据

    validates :course, presence: true

    scope :enabled, ->{where(enabled: true)}

    # TODO 把全文搜索相关的逻辑写在这个对象上
  end
end
