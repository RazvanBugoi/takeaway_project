class CreateDish
    def initialize(title, price, availability)
        @title = title
        @price = price
        @availability = availability
    end

    def title
        fail "The title cannot be empty." if @title.strip.empty?
        return @title
    end

    def price
        fail "The price must be positive." if !@price.positive?
        return @price
    end

    def availability
        return @availability
    end

    def mark_available
        @availability = true
    end

    def available?
        availability
    end
end