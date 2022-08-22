# this class is meant to store instances of CreateDish class and also handle the methods related to placing an order.

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
        available_dish_titles = ""

        available.each { |el| available_dish_titles << el[:title] }
        ordered = @args.all? { |dish| available_dish_titles.include?(dish) }
        # binding.irb
        fail "You cannot order an unavailable dish." if ordered == false
        return "Your order has been placed."
    end

    def print_receipt
        @available_dishes.keep_if do |hash|
            @args.include?(hash[:title])
        end

        receipt = @available_dishes.map do |hash|
            "#{hash[:title]}: £#{hash[:price]}\n"
        end

        total = " TOTAL: £#{ @available_dishes.map { |el| el[:price] }.sum }"

        return receipt.join(" ").concat(total)
    end
end