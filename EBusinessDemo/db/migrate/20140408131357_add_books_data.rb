class AddBooksData < ActiveRecord::Migration
  def up
    File.readlines("/tmp/final.csv").each do |line|
      items = lines.split(',')
      print items
      year = items[4].split('年')
      month = year[1].split('月')
      Books.create title: items[0], price: items[1].to_f(), publisher: items[2], author: items[3], publish_date: data.new(year[0].to_i(), month[0].to_i()), amazon_link: items[5]
    end
  end

  def down
    Books.delete_all
  end

end

