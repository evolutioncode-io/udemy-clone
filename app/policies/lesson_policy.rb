class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.has_role?(:admin) || @record.course.user_id == @user.id || @record.course.bough(@user) == false
  end
  
  def edit?
    @user.present? && @record.course.user_id == @user.id
  end

  def update?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def new?
    # @user.has_role?(:teacher)
  end

  def create?
    @record.course.user_id == @user.id
  end

  def destroy?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end
end