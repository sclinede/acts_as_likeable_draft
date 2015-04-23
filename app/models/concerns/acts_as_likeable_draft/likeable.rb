# It should configure redis_counter and redis_counters-dumpers depend on
# settings and subject which module included
#
# Also it should add readers for current likes/dislikes values for model
#
module ActsAsLikeableDraft
  module Likable

    # ??? How to sync with DB ???
    delegate :likes, :dislikes, to: :votes_storage

    included do
      configure_counters
      configure_dumpers
    end

    module ClassMethods
      def configure_counters
        # ...
      end

      def configure_dumpers
        # ...
      end
    end

    def votes_storage
      # ...
    end
  end
end
