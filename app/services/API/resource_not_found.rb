# frozen_string_literal: true

module API
  class Error < StandardError; end

  class ResourceNotFound < Error
  end
end
