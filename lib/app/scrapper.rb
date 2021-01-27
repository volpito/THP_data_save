require 'nokogiri'
require 'open-uri'
#public


class Scrapping

	def get_townhall_email(townhall_url)
		finarray = []
		doc = Nokogiri::HTML(URI.open(townhall_url))
		doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |link|
			finarray.push(link.content)
	end
	return finarray
end

def get_townhall_urls
	list = []
	arr_name = []
	final = []

	page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
	page.xpath('//a[contains(@href, "95")]/@href').each do |i|
		list.push(i.value)
	end

	name = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
	name.xpath('//a[contains(@href, "95")]').each do |i|
		arr_name.push(i.text)
	end

	list.each do |i|
		i = i[1..-1]
		tmp = 'https://www.annuaire-des-mairies.com' + i 
		final.push(get_townhall_email(tmp))
	end

	final = arr_name.zip(final).to_h
	return final
	end



def save_as_JSON
	File.open("../../db/emails.json","w") do |f|
	final.each{|f| f.write(i.to_json)}
end

def perform
	get_townhall_urls
end
        
end 



# array = "\{ \"#{link.content}\" => " << "#{price.content} \}, "

#def perform 
	
		#puts get_townhall_email('https://www.annuaire-des-mairies.com/95/avernes.html')
#		Scrapping.get_townhall_urls

#end

	

















