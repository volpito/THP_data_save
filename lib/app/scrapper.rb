	require 'nokogiri'
	require 'open-uri'


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

	def save_json 
		  @municipalities = get_townhall_urls
			File.open("db/emails.json", "w") do |file|
			file.write(JSON.pretty_generate(@municipalities))
		end
	end
	
	def perform
  	save_json
	end

end
