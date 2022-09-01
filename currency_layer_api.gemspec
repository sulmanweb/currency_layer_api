# frozen_string_literal: true

require_relative "lib/currency_layer_api/version"

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name = "currency_layer_api"
  spec.version = CurrencyLayerApi::VERSION
  spec.authors = ["Sulman Baig"]
  spec.email = ["sulman@hey.com"]

  spec.summary = "Currency Layer API is a light wrapper for currencylayer.com API for Rubyists."
  spec.description = "Currency Layer API is a light wrapper for currencylayer.com API for Rubyists. It gives nice struct objects for currencies and conversions. It uses Faraday for HTTP requests." # rubocop:disable Layout/LineLength
  spec.homepage = "https://github.com/sulmanweb/currency_layer_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  # spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sulmanweb/currency_layer_api"
  spec.metadata["changelog_uri"] = "https://github.com/sulmanweb/currency_layer_api/blob/main/CHANGELOG.md"

  spec.files =
    Dir.chdir(__dir__) do
      `git ls-files -z`.split("\x0").reject do |f|
        (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
      end
    end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.md]

  spec.add_dependency("faraday", "~> 2.5")
  spec.add_development_dependency("rubocop", "~> 1.35")
  spec.metadata["rubygems_mfa_required"] = "true"
end
