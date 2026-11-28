module ReadingTimeHelper
  WORDS_PER_MINUTE = 200

  # Returns a label such as "3 min read" for the words in text, or "" when there are none.
  # Words are runs of non-whitespace; String#split ignores leading, trailing and repeated whitespace.
  def reading_time_label(text)
    words = text.to_s.split.size
    return "" if words.zero?

    minutes = [(words.to_f / WORDS_PER_MINUTE).ceil, 1].max
    "#{minutes} min read"
  end
end
