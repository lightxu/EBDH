require 'csv'


class SelectOnBooks < ActiveRecord::Migration
  def up
	counter = 0
	real = 0
	conn = ActiveRecord::Base.connection
	i = 0
	CSV.foreach("/tmp/small_size.csv") do |items|
		begin
			if (counter % 10 == 0)
				item = items.map{|items| Book.sanitize(item)}
				name = items[0]
#				print "name: #{name} \n"
				begin
					find = Book.find(:all, :conditions=>"title = '#{name}'" )
				rescue
					print "Error: did not find #{name} \n"
				end
				real = real + 1
				if (real % 1000 == 0)
					print "#{real} finished!"
				end
			end
			counter = counter + 1
		rescue
		end
		#print find
	end
  end

  def down
  end

end
