
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asset_definition_file_uploader/version"

Gem::Specification.new do |spec|
  spec.name          = "asset_definition_file_uploader"
  spec.version       = AssetDefinitionFileUploader::VERSION
  spec.authors       = ["NishidaRyu416"]
  spec.email         = ["nishidaryu416@gmail.com"]

  spec.summary       =  %q{You can make the asset definition file that is used on open assets protocol with this gem easily}
  spec.description   =  %q{This gem enables you to make the assets definition file easily but also you can upload the file you make with this gem or you make without this to gist.if you want to make the url you upload to short then this gem will help you as well}
  spec.homepage      = "https://ryu-nishida.blogspot.jp/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'google_url_shortener'
end
