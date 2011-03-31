require "pathname"

module Fixtures

  def fixture_path(name)
    Pathname(__FILE__).parent.parent.parent + "fixtures" + name
  end

  def fixture_url(name)
    "file://#{fixture_path(name).realpath}"
  end

end
