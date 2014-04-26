class BookQueryTest < ActiveRecord::Migration
  def up
	  conn = ActiveRecord::Base.connection
	  for i in 1..10000
	  seed = rand(100)
		if (seed < 30) 
			  limit_low = rand(1000) + 1
			  limit_high = limit_low + rand(1000)
#			  print 0
		else
			  limit_low = rand(40000) + 1
			  limit_high = limit_low + rand(40000)
#			  print 1
		end
		book = Book.find([limit_low, limit_high])
	  end
  end

  def down
  end
end
