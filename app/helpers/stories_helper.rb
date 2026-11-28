module StoriesHelper
  def show_guidelines?(user)
    if !user
      return true
    end

    if user.stories_submitted_count <= 5
      return true
    end

    if Moderation.joins(:story)
        .where(
          "stories.user_id = ? AND moderations.created_at > ?",
          user.id,
          5.days.ago
        ).exists?
      return true
    end

    false
  end

  def reading_time_label(text)
    return "" if text.nil?

    words = text.split.size
    return "" if words.zero?

    minutes = (words + 199) / 200
    "#{minutes} min read"
  end
end
