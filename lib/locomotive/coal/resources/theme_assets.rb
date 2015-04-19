module Locomotive::Coal
  module Resources

    class ThemeAssets < Base

      def checksums
        get('theme_assets/checksums')
      end

    end

  end
end
