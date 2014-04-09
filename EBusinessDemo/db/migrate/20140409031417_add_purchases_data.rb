class AddPurchasesData < ActiveRecord::Migration
  def up
	  conn = ActiveRecord::Base.connection
	  i = 0
	  inserts = []
	  for i in 0..1000000
		  user_id = 1;
		  seed = rand(10)
		  if (seed<4)
			  book_id = rand(100)
		  else
			  book_id = rand(100000)
		  end
		  purchase_time = Date.today-rand(60)
		  # print purchase_time
		  
		  #insert per row into purchases list
		  begin
			  inserts.push"('#{user_id}', '#{book_id}', '#{purchase_time}')"
		  rescue
			  print "Error no: #{i}"
		  end

		  if (i % 10000 == 0)
			  print "Parse #{i} lines finished!\n"
			  # print inserts.last
			  sql = "INSERT INTO purchases (`user_id`, `book_id`, `purchase_time`) VALUES #{inserts.join(", ")}"
			  conn.execute sql
			  inserts = []
		  end
	  end
  end
  def down
	  Purchase.delete_all
  end

end
