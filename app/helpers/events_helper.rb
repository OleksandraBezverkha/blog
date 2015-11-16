module EventsHelper
  def check(id)
  Post.find_by_id(id)
  end
end