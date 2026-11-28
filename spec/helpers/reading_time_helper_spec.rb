require "rails_helper"

describe ReadingTimeHelper do
  describe "#reading_time_label" do
    it "[QP-SMRAILS-6-1] Labels a 450-word text as 3 min read" do
      text = Array.new(450, "word").join(" ")
      expect(helper.reading_time_label(text)).to eq("3 min read")
    end

    it "[QP-SMRAILS-6-2] Labels a 10-word text as 1 min read" do
      text = Array.new(10, "word").join(" ")
      expect(helper.reading_time_label(text)).to eq("1 min read")
    end

    it "[QP-SMRAILS-6-3] Rounds up when the word count passes a multiple of 200" do
      text = Array.new(201, "word").join(" ")
      expect(helper.reading_time_label(text)).to eq("2 min read")
    end

    it "[QP-SMRAILS-6-4] Returns an empty string for nil text" do
      expect(helper.reading_time_label(nil)).to eq("")
    end

    it "[QP-SMRAILS-6-5] Returns an empty string for text containing only whitespace" do
      expect(helper.reading_time_label(" \t\n \n\t ")).to eq("")
    end

    it "[QP-SMRAILS-6-6] Counts runs of whitespace as a single separator" do
      separators = ["  ", "\n"]
      words = Array.new(200, "word")
      text = " " + words.each_with_index.map { |word, i| (i.zero? ? word : separators[i % 2] + word) }.join
      expect(helper.reading_time_label(text)).to eq("1 min read")
    end
  end
end
