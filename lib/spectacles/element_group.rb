module Spectacles

  module ElementGroup

    [:centre, :location, :width, :height, :size].each do |property|
      element_method_name = "same_#{property}_as?"
      define_method("same_#{property}?") do
        all_same?(element_method_name)
      end
    end

    [:top, :right, :bottom, :left, :vertically, :horizontally].each do |axis|
      element_method_name = "#{axis}_aligned_with?"
      define_method("#{axis}_aligned?") do
        all_same?(element_method_name)
      end
    end

    private

    def all_same?(method_name)
      first, *remainder = self
      remainder.all? do |element|
        element.send(method_name, first)
      end
    end

  end

end

class Array
  # TODO: YUK!
  include Spectacles::ElementGroup
end
