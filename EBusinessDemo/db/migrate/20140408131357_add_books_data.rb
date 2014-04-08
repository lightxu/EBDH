class AddBooksData < ActiveRecord::Migration
  def up
    File.readlines("/file/path").each do |line|
      items = lines.split(',')
      print items
      Books.create title: items[0]
    end
  end

  def down
    Books.delete_all
  end

end
