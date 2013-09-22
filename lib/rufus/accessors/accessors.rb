module Rufus
  module Accessors

    def view(name, locator)
      define_method("#{name}_view") do
        Rufus::Accessors::View.new(locator)
      end
      define_method("#{name}") do
        Rufus::Accessors::View.new(locator).click
      end
    end

    def label(name, locator)
      view(name, locator)
    end

    def text(name, locator)
      view(name, locator)
    end

    def button(name, locator)
      view(name, locator)
    end
  end
end