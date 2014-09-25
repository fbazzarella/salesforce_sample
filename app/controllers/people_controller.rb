class PeopleController < ApplicationController
  def index
    respond_with @people = people.order(:name)
  end

  def new
    respond_with @person = people.new
  end

  def create
    respond_with @person = people.create(person_params), location: people_path
  end

  private

  def people
    current_user.people
  end

  def person_params
    params.require(:person).permit(Person::COMMON_FIELDS)
  end
end
