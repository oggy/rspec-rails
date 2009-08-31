class ActionController::IntegrationTest
  alias_method :orig_initialize, :initialize
  def initialize(*args)
    super
  end
end

module Spec
  module Rails
    module Example
      class IntegrationExampleGroup < ActionController::IntegrationTest
        Spec::Example::ExampleGroupFactory.register(:integration, self)

        # Although the modules below are included in AS::TestCase, we
        # need to include them again here since in rails (<= 2.3.3),
        # AC::IntegrationTest fails to propagate unhandled
        # method_missings up the ancestor chain, and some of these
        # modules rely on method_missing.  Rails bug filed at:
        # http://rails.lighthouseapp.com/projects/8994/tickets/3119
        #
        # We dup the modules to force ruby to include them.  Otherwise
        # ruby detects that the modules are included further up the
        # chain, and skips them.
        include ::Spec::Matchers.dup
        include ::Spec::Rails::Matchers.dup
        include ::Spec::Rails::Mocks.dup
      end
    end
  end
end
