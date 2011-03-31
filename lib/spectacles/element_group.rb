module Spectacles

  module ElementGroup

    [:top, :right, :bottom, :left].each do |edge|
      define_method("#{edge}_aligned?") do
        same?(:"#{edge}_edge")
      end
    end

    [:centre, :location, :width, :height, :size].each do |property|
      define_method(:"same_#{property}?") do
        same?(property)
      end
    end

    private

    def same?(property)
      map(&property).uniq.size == 1
    end

  end

end

class Array
  # TODO: YUK!
  include Spectacles::ElementGroup
end
