require 'json'

def setup_files
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$products_hash = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end
##############PRODUCTS METHODS#################

def print_asci_art_product
	puts "                     _            _       "
	puts "                    | |          | |      "
	puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
	puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
	puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
	puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
	puts "| |                                       "
	puts "|_|                                       "
	puts
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

def print_name_of_toy (position_in_array_of_toy)
	puts $products_hash["items"][position_in_array_of_toy]["title"]
end

def print_full_price (position_in_array_of_toy)
	puts "Price of toy: $#{$products_hash["items"][position_in_array_of_toy]["full-price"]}"
end

def print_number_of_purchases(position_in_array_of_toy)
	puts "Number of purchases: #{$products_hash["items"][position_in_array_of_toy]["purchases"].size}"
end

def print_amout_of_sales (position_in_array_of_toy)
	puts "Amount of sales: $#{calculate_amount_of_sales(position_in_array_of_toy)}"
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

def print_average_price_the_toy_sold_of(position_in_array_of_toy)
	puts "Average price: $#{calculate_average_price_the_toy_sold_of(position_in_array_of_toy)}" 
end

def calculate_average_price_the_toy_sold_of(position_in_array_of_toy)
	average = calculate_amount_of_sales(position_in_array_of_toy) / $products_hash["items"][position_in_array_of_toy]["purchases"].size
	average
end

def calculate_average_discount(position_in_array_of_toy)
	average_discount = (1 - calculate_amount_of_sales(position_in_array_of_toy) / $products_hash["items"][position_in_array_of_toy]["purchases"].size / $products_hash["items"][position_in_array_of_toy]["full-price"].to_i)*100
	average_discount
end

def print_average_discount(position_in_array_of_toy)
	puts "Average discount: #{calculate_average_discount(position_in_array_of_toy).round(2)}%" 
end


################BRANDS METHODS######################
def print_asci_art_brand
	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts
end

def print_all_about_brands()
	i = 0
	uniq_brands = make_an_array_of_unique_brands
	while i < uniq_brands.length do 
		stock = 0
		number_of_toys = 0
		sum_of_prices = 0
		brand_revenue = 0
		puts uniq_brands[i]
		k = 0
		while k < $products_hash["items"].length do
			if uniq_brands[i] == $products_hash["items"][k]["brand"]
				stock  = calculate_stock_of_brand(stock,k) 
				sum_of_prices = adds_prices_of_toys(sum_of_prices,k)
				brand_revenue = adds_toys_revenues(brand_revenue,k)
				number_of_toys = number_of_toys + 1
			end
		k = k + 1
		end
		average_price_of_toy = calculate_average_price_of_toy(sum_of_prices,number_of_toys)
		print_stock(stock)
		print_average_price_of_toy(average_price_of_toy)
		print_brand_revenue(brand_revenue)
		puts

		i = i + 1
	end
end

def make_an_array_of_unique_brands 
	brands = []
	$products_hash["items"].each do |toy| # Loop makes an array with all brands
		brands.push(toy["brand"])
	end
	uniq_brands=brands.uniq 	# Array with unique brands
end

def calculate_stock_of_brand (stock_till_now,position_in_array_of_toy)
	stock = stock_till_now + $products_hash["items"][position_in_array_of_toy]["stock"].to_i # Calculates stock for every brand
end

def adds_prices_of_toys(added_prices_till_now,position_in_array_of_toy)
	sum_of_prices = added_prices_till_now + $products_hash["items"][position_in_array_of_toy]["full-price"].to_f # Adds toy's prices of toys. 
end

def adds_toys_revenues(added_revenues_till_now,position_in_array_of_toy)
	k = 0
	brand_revenue = added_revenues_till_now
	while k < $products_hash["items"][position_in_array_of_toy]["purchases"].length do # Loop that calculate brand revenue
		brand_revenue = (brand_revenue + $products_hash["items"][position_in_array_of_toy]["purchases"][k]["price"].to_f).round(2)
		k = k+1
	end
	brand_revenue
end
def calculate_average_price_of_toy(sum_of_prices,number_of_toys)
	average_price_of_toy = (sum_of_prices/number_of_toys).round(2) 
end
def print_stock (stock)
	puts "Stock: #{stock}"
end

def print_average_price_of_toy(average_price_of_toy)
	puts "Average price of toy: $#{average_price_of_toy}"
end

def print_brand_revenue(brand_revenue)
	puts "Brand's revenue: $#{brand_revenue}"
end


#############################MAIN BODY#############################
setup_files
puts "Sales Report"
# Print "Sales Report" in ascii art

time = Time.new
puts time
puts
# Print today's date

print_asci_art_product
# Print "Products" in ascii art

print_all_about_products
# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price
print_asci_art_brand
# Print "Brands" in ascii art

print_all_about_brands
# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
