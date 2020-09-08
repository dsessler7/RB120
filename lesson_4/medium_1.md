# Lesson 4: Practice Problems: Medium 1:

## Q1

Ben is correct. There is a getter method available (via attr_reader) for the `@balance` instance variable, so 'balance' in the `positive_balance?` method will call that getter method.

## Q2

The mistake is that there is no setter method for `@quantity` and the code in the `update_quantity` method doesn't reference the `@quantity` instance variable directly (no '@' on the front of 'quantity'), so it will fail with an 'undefined method or variable' error message.

There are a couple of ways to fix this. 
1. Create a getter for the `@quantity` instance variable (either add an 'attr_writer' or change the 'attr_reader' to 'attr_accessor' for ':quantity') and then add `self.` to the front of `quantity` on line 11.
2. Just add a `@` to the front of `quantity` on line 11 to access the instance variable directly.

## Q3

The problem with this approach is that now the `@quantity` instance variable could be changed by anyone without even using the `update_quantity` method. The `@quantity` getter should probably be made protected so that it can only be accessed by other instance methods.

Also, if `attr_reader` is just switched to `attr_accessor` then a setter will also be created for `@product_name` which we might not want.

## Q4

```ruby
class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

## Q5

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    @filling_type ? type = @filling_type : type = "Plain"
    @glazing ? type + " with #{@glazing}" : type
  end
end
```

## Q6

In the first version of the code, the `create_template` method accesses the `@template` instance variable directly whereas the `show_template` method accesses template via the getter method.

In the second version, the `create_template` uses the setter method to acces 'template'. The `show_template` method again uses the getter method, but has an unneeded `self` prefixing the method call.

## Q7

I would delete 'light_' off of the `light_status` method name since it is a class method and so we already know we will be calling it on the `Light` class.
