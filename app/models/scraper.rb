require "open-uri"
#http://stackoverflow.com/questions/242602/how-do-i-make-a-post-request-with-open-uri 
# --use rest open uri to make a post request on this page: http://www.nyc.gov/lobbyistsearch/directory.jsp
# because nyc.go/lobbyistwhatever sucks

class Scraper < ActiveRecord::Base

  def submit_form
    url = "http://www.nyc.gov/lobbyistsearch/directory.jsp"
    agent = Mechanize.new
    page = agent.get(url)
    form = agent.page.forms.first
    year = form.field_with(:name => 'year_select').options[1].click
    view = form.field_with(:name => 'view_select').options[2].click
    form.submit
  end

  def collect_lobbyist_org_links
    submit_form.search("td tr a.backtolist").map do |link|
      "http://www.nyc.gov/lobbyistsearch/#{link.attr("href")}"
    end
  end

 
  def lobbyist_org_first_pages
    collect_lobbyist_org_links.map do |link|
      puts "#{link}"
      begin
        Nokogiri::HTML(open(link))
      rescue OpenURI::HTTPError => error # if it don't
        if error.message == "404 Not Found"
          #empty for now
        else
          raise error
        end
      end
    end.compact
  end

  # def collect_page_numbers
  #   numbers = lobbyist_org_first_pages.each do |page|
  #     page.css("tr td").map do |td|
  #       next if (td['colspan'] != 8)
  #     end
  #   end
  #   binding.pry
  # end




 

  
  
end
