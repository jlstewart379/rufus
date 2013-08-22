module Rufus
  module Accessors

    def view(name, locator)
      define_method("#{name}_view") do
        Rufus::Accessors::View.new(locator)
      end
   end

  end
end