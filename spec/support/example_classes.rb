class ApplicationAuthorizer < Authority::Authorizer
  def self.readable_by?(user, options = {})
    default(:readable, user, options)
  end
end

class ExampleUser
  include Authority::UserAbilities
end

class ExampleResourceAuthorizer < ApplicationAuthorizer
end

class ExampleResource
  include Authority::Abilities
end

module Namespaced
  class SampleResourceAuthorizer < ApplicationAuthorizer
  end

  class SampleResource
    include Authority::Abilities
  end

end

class OtherResource
  include Authority::Abilities
end
