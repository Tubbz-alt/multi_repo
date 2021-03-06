require_relative 'lib/multi_repo/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_repo"
  spec.version       = MultiRepo::VERSION
  spec.authors       = ["ManageIQ Authors"]

  spec.summary       = %q{MultiRepo is a library to help build tools that need to run against multiple git and GitHub repositories.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ManageIQ/multi_repo"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "aws-sdk-s3"
  spec.add_dependency "builder"
  spec.add_dependency "config"
  spec.add_dependency "licensee"
  spec.add_dependency "minigit"
  spec.add_dependency "more_core_extensions"
  spec.add_dependency "octokit", ">=4.7.0"
  spec.add_dependency "optimist"
  spec.add_dependency "rest-client"
  spec.add_dependency "travis"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
