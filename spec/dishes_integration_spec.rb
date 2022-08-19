require 'dishes'
require 'create_dish'

RSpec.describe "Integration Tests" do
    context "#add & #all" do
        it "adds dishes to the menu and displays them as a list" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            dish_3 = CreateDish.new("Fish and Chips", 5.99, true)
            menu.add(dish_1)
            menu.add(dish_2)
            menu.add(dish_3)
            expect(menu.all).to eq [dish_1.to_hash, dish_2.to_hash, dish_3.to_hash]
        end

        it "raises an error if the list is empty" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            expect{ menu.all }.to raise_error "The menu cannot be empty."
        end

    end

    context "#available" do
        it "Displays a list of available dishes" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            dish_3 = CreateDish.new("Fish and Chips", 5.99, true)
            menu.add(dish_1)
            menu.add(dish_2)
            menu.add(dish_3)
            expect(menu.available).to eq [dish_1.to_hash, dish_3.to_hash]
        end

        it "Raises an error if the list is empty" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, false)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            menu.add(dish_1)
            menu.add(dish_2)
            expect{ menu.available }.to raise_error "There must be at least 1 available dish at any given time."
        end
    end

    context "#place_order" do
        it "allow users to place an order if the dishes they want are available" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            dish_3 = CreateDish.new("Fish and Chips", 5.99, true)
            menu.add(dish_1)
            menu.add(dish_2)
            menu.add(dish_3)
            expect(menu.place_order("Roast Dinner", "Fish and Chips")).to eq "Your order has been placed."
        end

        it "fails if one or more dish dishes are unavailable" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            dish_3 = CreateDish.new("Fish and Chips", 5.99, true)
            menu.add(dish_1)
            menu.add(dish_2)
            menu.add(dish_3)
            expect{ menu.place_order("Roast Dinner", "Gammon and Mash")}.to raise_error "You cannot order an unavailable dish."
        end
    end

    context "#print_receipt" do
        it "returns an itemised receipt with a grand total" do
            menu = Dishes.new
            dish_1 = CreateDish.new("Roast Dinner", 9.99, true)
            dish_2 = CreateDish.new("Gammon and Mash", 8.99, false)
            dish_3 = CreateDish.new("Fish and Chips", 5.99, true)
            menu.add(dish_1)
            menu.add(dish_2)
            menu.add(dish_3)
            menu.place_order("Roast Dinner", "Fish and Chips")
            expect(menu.print_receipt).to eq "Roast Dinner: £9.99\n Fish and Chips: £5.99\n TOTAL: £15.98"
        end
    end
end