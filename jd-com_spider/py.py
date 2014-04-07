import os,urllib2
import string
from BeautifulSoup import BeautifulSoup
import csv, sys

url_head = "http://search.jd.com/search?keyword=%CA%E9&rt=1&book=y&ev=&area=15&page="
url_tail = ""

csvfile = file('D:/gruber/out.csv', 'wb')
writer = csv.writer(csvfile)


for i in range(1,100):
	page_str = str(i)
	url = url_head + page_str + url_tail
	print(url)
	response = urllib2.urlopen(url)
	html = response.read()
	# html = html.decode('gbk')
	# html = html.encode('2312')
	# print(html)
	my_soup = BeautifulSoup(html);
	# print my_soup.prettify();
	items = my_soup.findAll('div', {"class": "item"});

	for item in items:
		book_name = ''
		book_price = ''
		publisher = ''
		book_author = ''
		publish_time = ''
		a_link = ''
		#name
		my_item = BeautifulSoup(str(item))
		p_name = my_item.findAll("dt", {"class": "p-name"});
		for name in p_name:
			book_name = name.contents[1].contents[0]
			book_name = book_name.encode('gbk').strip();
			book_name = str(book_name)
			# book_name = book_name.encode('gbk')
			# print(book_name)
			a_link = name.contents[1]['href'];
			a_link = a_link.encode('gbk');
			# a_link = str(a_link)
			# print(a_link)


		#price
		p_market = my_item.findAll('dd', {"class": "p-market"});
		for market in p_market:
			book_price = market.contents[3].contents[0].contents[0];
			book_price = book_price.encode('gbk')
			# book_price = str(book_price)
			# print(book_price)

		#SUMMARY
		summary = my_item.findAll("ul", {"class" : "summary"});
		for smr in summary:
			my_smr = BeautifulSoup(str(smr));
			summary_press = my_smr.findAll("li", {"class" : "summary-press"});
			if (len(summary_press) != 0):
				publisher = summary_press[0].contents[3].contents[0].contents[0];
				publisher = publisher.encode('gbk')
				# publisher = str(publish_time)
				# print(publisher)


			summary_time = my_smr.findAll("li", {"class" : "summary-time"});
			if (len(summary_time) != 0):
				publish_time = summary_time[0].contents[3].contents[0];
				publish_time = publish_time.encode('gbk')
				# publish_time = str(publish_time)
				# print(publish_time)


			summary_author = my_smr.findAll("li", {"class" : "summary-author"})
			print(len(summary_author))

			if (len(summary_author) != 0):
				author = summary_author[0].contents[3]
				author_a = BeautifulSoup(str(author))
				author_q = author_a.findAll('a');
				book_author = author_q[0].contents[0];
				book_author = book_author.encode('gbk')

		writer.writerow([book_name, book_price, publisher, book_author, publish_time, a_link])


