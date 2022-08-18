class Dishes
    def initialize
        @all_dishes = []
        @available_dishes = []
    end

    def add(dish)
        @all_dishes << dish.to_hash
    end

    def all
        fail "The menu cannot be empty." if @all_dishes.empty?
        return @all_dishes
    end

    def available
        @available_dishes = @all_dishes.select { |element| element[:availability] == true }
        fail "There must be at least 1 available dish at any given time." if @available_dishes.empty?
        return @available_dishes
    end

    def place_order(*args)
        @args = *args

        items_available = @args.all? do |element|
            @available_dishes.all? { |element| element[:availability] == true }
        end

        return "Your order has been placed." if items_available
    end
end