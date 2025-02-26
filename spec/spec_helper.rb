RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Allow RSpec to persist state between runs to support `--only-failures`
  config.example_status_persistence_file_path = "tmp/test_output.txt"

  # Limit available syntax to non-monkey patched syntax.
  config.disable_monkey_patching!

  # Enable detailed output when running an individual spec file.
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples at the end of the run.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies.
  config.order = :random
  Kernel.srand config.seed
end
