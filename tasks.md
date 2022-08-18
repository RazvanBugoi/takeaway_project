# {{PROBLEM}} Multi-Class Planned Design Recipe

## 1. Describe the Problem

_Put or write the user story here. Add any clarifying notes you might have._

<!-- 
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices. 

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.


Use the twilio-ruby gem to implement this next one. You will need to use doubles too.
As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.
-->

## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
to see
list of dishes with prices
to select some number
available dishes
to see
receipt with a grand total
to receive
text message after order placed



┌─────────────────────────────────────────────┐
│                                             │
│                                             │
│    Dishes                                   │
│    ------                                   │
│                                             │
│    - add                                    │
│    - all                                    │
│    - available                              │
│    - place_order                            │
│    - print_receipt                          │
│    - send_confirmation_text                 │
│                                             │
│                                             │
│                                             │
│                                             │
└─────────────┬───────────────────────────────┘
              │
              │
              │
              │
              │ Dishes has zero or more
              │ instances of CreateDish
              │
              │
              │
              │
              │
              ▼

 ┌─────────────────────────────────────────────┐
 │                                             │
 │                                             │
 │    CreateDish                               │
 │    ----------                               │
 │                                             │
 │    - title                                  │
 │    - price                                  │
 │    - mark_available                         │
 │    - available?                             │
 │    - mark_unavailable                                        │
 │                                             │
 │                                             │
 └─────────────────────────────────────────────┘
```

_Also design the interface of each class in more detail._

```ruby
class Dishes
    def initialize
        # ...
    end

    def add(dish) # dish is an instance of CreateDish
        # Dish gets added to the menu(list of dishes)
        # Returns nothing
    end

    def all
        # Returns a list of all dishes
    end
    
    def available
        # Returns a list of all available dishes
    end

    def place_order(*args) # *args represents the title of the dishes you want to order as strings
        # Returns "Your order has been placed. You will receive a confirmation text shortly." if order has gone through successfully
        # Fails if unsuccessful
    end

    def print_receipt
        # Returns an itemised receipt with a grand total
    end

    def send_confirmation_text
        # Sends a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.
    end
end

class CreateDish
    def initialize(title, price, availability) # title is a string, price is a float
    end

    def title
        # Returns the title of the dish as a string
    end

    def price
    # Returns the price of the dish as an integer
    end

    def availability
    # Returns the availability of the dish as a boolean
    end

    def mark_available
    # Marks the dish as available
    end

    def mark_unavailable
    # Marks the dish as unavailable
    end

    def available?
    # Cheks if the dish is available
    end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# Gets all tracks
menu = Dishes.new
dish_1 = CreateDish.new("Fries", 1.99, true)
dish_2 = CreateDish.new("Burger", 3.99, false)
menu.add(dish_1)
menu.add(dish_2)
menu.all # => [dish_1, dish_2]
menu.available # => [dish_1]
menu.place_order("Fries") # => "Your order has been placed. You will receive a confirmation text shortly."
menu.print_receipt # => ["Fries": 1.99\n "Total": £1.99]
menu.send_confirmation_text # => "Thank you! Your order was placed and will be delivered before 18:52"
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Creates a dish and returns it's title, price and availability
dish_1 = CreateDish.new("Fries", 1.99, true)
dish_1.title # => "Fries"
dish_1.price # => 1.99
dish_1.availability # => true

# Make the dish unavailable to order
dish_1 = CreateDish.new("Fries", 1.99, true)
dish_1.title # => "Fries"
dish_1.price # => 1.99
dish_1.availability # => true
dish_1.mark_unavailable # => "The dish is now unavailable."
dish_1.availability # => false

# Check if the dish is available to order
dish_1 = CreateDish.new("Fries", 1.99, true)
dish_1.title # => "Fries"
dish_1.price # => 1.99
dish_1.availability # => false
dish_1.available? # => dish_1.availability
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._