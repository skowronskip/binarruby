class Animal
	attr_accessor :name, :age

	def initialize(name, age)
		@name = name
		@age = age
	end

	def give_sound
		puts 'default sound'
	end

	def introduce
		puts @name
	end
end

class Snake < Animal

	def give_sound
		puts 'sssssssssssss'
	end
end

class Cat < Animal

	def give_sound
		puts 'miau!'
	end
end

animal = Cat.new('Reksio', 6)
animal.introduce
animal.give_sound
