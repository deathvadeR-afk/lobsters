require "rails_helper"

describe StoriesHelper do
  describe "#reading_time_label" do
    def words(count, separator = " ")
      Array.new(count, "word").join(separator)
    end

    it "[QP-SMRAILS-8-1] Returns the rounded-up minute count for a 450-word text" do
      expect(helper.reading_time_label(words(450))).to eq("3 min read")
    end

    it "[QP-SMRAILS-8-2] Floors a short text at one minute" do
      expect(helper.reading_time_label(words(10))).to eq("1 min read")
    end

    it "[QP-SMRAILS-8-3] Rounds up exactly at the 200-word boundary" do
      expect(helper.reading_time_label(words(200))).to eq("1 min read")
      expect(helper.reading_time_label(words(201))).to eq("2 min read")
    end

    it "[QP-SMRAILS-8-4] Returns an empty string for nil text" do
      expect(helper.reading_time_label(nil)).to eq("")
    end

    it "[QP-SMRAILS-8-5] Returns an empty string for blank text" do
      expect(helper.reading_time_label("")).to eq("")
      expect(helper.reading_time_label(" \t\n  ")).to eq("")
    end

    it "[QP-SMRAILS-8-6] Ignores irregular and padded whitespace when counting words" do
      text = "  #{words(200, "  \t\n")} \n\t  "
      expect(helper.reading_time_label(text)).to eq("1 min read")
    end
  end
end
