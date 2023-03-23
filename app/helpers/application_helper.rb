module ApplicationHelper
  def convert_to_hours_and_minutes(minutes)
    hours = minutes / 60
    minutes = minutes % 60
    "#{hours}hr #{minutes}min"
  end
end
