if RUBY_PLATFORM =~ /linux/
  module Launchy
    class Browser
      class WslBrowser < Browser
        def self.handles?(browser)
          %w[ wslview ].include?(browser)
        end

        def browser_cmdline(browser, uri)
          [ browser, uri.to_s ]
        end
      end

      def self.browser_classes
        @browser_classes ||= super().push(WslBrowser)
      end
    end
  end
end