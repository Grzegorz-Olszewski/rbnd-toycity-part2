require 'json'

def setup_files
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$products_hash = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end

def print_name_of_toy (position_in_array_of_toy)
	puts $products_hash["items"][position_in_array_of_toy]["title"]
end

def print_full_price (position_in_array_of_toy)
	puts $products_hash["items"][position_in_array_of_toy]["full-price"]
end

def print_number_of_purchases(position_in_array_of_toy)
	puts "Number of purchases: #{$products_hash["items"][position_in_array_of_toy]["purchases"].size}"
end

def calculate_amount_of_sales(position_in_array_of_toy)
	i = 0
	amount_of_sales = 0
	while i < $products_hash["items"][position_in_array_of_toy]["purchases"].size	# Loop that is adding sales, and store it in amount_of_sales variable. 
		amount_of_sales = amount_of_sales + $products_hash["items"][position_in_array_of_toy]["purchases"][i]["price"]
		i = i + 1
	end
	amount_of_sales
end

def print_amout_of_sales (position_in_array_of_toy)
	puts "Amount of sales: $#{calculate_amount_of_sales(position_in_array_of_toy)}"
end

def calculate_average_price_the_toy_sold_of(position_in_array_of_toy)
	average = calculate_amount_of_sales(position_in_array_of_toy) / $products_hash["items"][position_in_array_of_toy]["purchases"].size
	average
end

def print_average_price_the_toy_sold_of(position_in_array_of_toy)
	puts "Average price: $#{calculate_average_price_the_toy_sold_of(position_in_array_of_toy)}" 
end

def calculate_average_discount(position_in_array_of_toy)
	average_discount = (1 - calculate_amount_of_sales(position_in_array_of_toy) / $products_hash["items"][position_in_array_of_toy]["purchases"].size / $products_hash["items"][position_in_array_of_toy]["full-price"].to_i)*100
	average_discount
end

def print_average_discount(position_in_array_of_toy)
	puts "Average discount :#{calculate_average_discount(position_in_array_of_toy).round(2)}%" 
end

def print_all_about_products
	i = 0
	while i < $products_hash["items"].length
		print_name_of_toy(i)
		print_full_price(i)
		print_number_of_purchases(i)
		print_amout_of_sales(i)
		print_average_price_the_toy_sold_of(i)
		print_average_discount(i)
		puts
		i = i + 1
	end
end

setup_files
# Print "Sales Report" in ascii art
puts "Sales Report"
# Print today's date
time = Time.new
puts time
puts
# Print "Products" in ascii art
puts "Products"
puts

print_all_about_products

# For each product in the data set:

	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art
puts "Brands"
puts

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
