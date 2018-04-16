module API
  class Error < StandardError; end

  class ResourceNotFound < Error
  end
end
