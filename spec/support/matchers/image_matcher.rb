module Capybara
  class Session
    def has_image?(src)
      has_xpatch?("//img[contains(@src, \"#{src}\")]")
    end
  end
end
