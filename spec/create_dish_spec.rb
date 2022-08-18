require 'create_dish'

RSpec.describe CreateDish do
    context "#title" do
        it "creates a dish and returns its title" do
            my_dish = CreateDish.new('Fries', 1.99, true)
            expect(my_dish.title).to eq "Fries"
        end
    
        it "raises an error if the title is empty" do
            my_dish = CreateDish.new('    ', 1.99, true)
            expect{ my_dish.title }.to raise_error "The title cannot be empty."
        end
    end

    context "#price" do
        it "Returns the price" do
            my_dish = CreateDish.new("Burger and Fries", 4.99, true)
            expect(my_dish.price).to eq 4.99
        end

        it "Raises an error if the price is not positive." do
            my_dish = CreateDish.new("Burger and Fries", 0, true)
            expect{ my_dish.price }.to raise_error "The price must be positive."
        end
    end

    context "#mark_available" do
        it "Marks dish as available to order" do
            my_dish = CreateDish.new("Burger and Fries", 4.99, false)
            my_dish.mark_available
            expect(my_dish.availability).to eq true
        end
    end

    context "#available?" do
        it "Checks if a dish is available to order" do
            my_dish = CreateDish.new("Burger and Fries", 4.99, false)
            expect(my_dish.available?).to eq false
        end
    end
end