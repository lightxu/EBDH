require 'date'
require 'csv'

class AddBooksData < ActiveRecord::Migration
  def up
	conn = ActiveRecord::Base.connection
	i = 0
	inserts = []
	CSV.foreach("/tmp/final.csv") do |items|
	  items = items.map{|item| Book.sanitize(item)}
	  # print items

	  begin
		  date_items = items[4].split('年')
		  year = date_items[0].to_i
		  month = date_items[1].split('月')[0].to_i
	  rescue
		  year = 0
		  month = 1
	  end

	  # Insert per row
	  # Book.create title: items[0], price: items[1].to_f(), publisher: items[2], author: items[3], "publish_date" => Date.new(year, month[0]), "amazon_link" => items[5]

	  # Batch insert
	  begin
	    inserts.push "(#{items[0]}, #{items[1]}, #{items[2]}, #{items[3]}, '#{Date.new(year, month).to_s}', #{items[5]})"
	  rescue
		print "Error: #{items}\n"
	  end
	  i = i + 1
	  if (i % 1000 == 0)
		  print "Parse #{i} lines finished!\n"
		  print inserts.last + "\n"
		  sql = "INSERT INTO books (`title`, `price`, `publisher`, `author`, `publish_date`, `amazon_link`) VALUES #{inserts.join(", ")}"
		  conn.execute sql
		  inserts = []
	  end
	  # break
    end
  end

  def down
    Book.delete_all
  end

end

