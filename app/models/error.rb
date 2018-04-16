module Error
  class ApplicationError < StandardError; end;
  class RecordNotFound < ApplicationError; end;
  class ResourcesNotSet < ApplicationError; end;
end
