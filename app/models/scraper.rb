require 'open-uri'

class Scraper < ActiveRecord::Base


  def get_index
    #response = rest-open-uri.post(index_url)
    #html = Nokogiri::HTML(response)
    Nokogiri::HTML(open(main_index_url)) 
  end

  def call
    student_data = get_index
    links_array = student_data.css("div.big-comment h3 a").collect do |link|
      "http://students.flatironschool.com/#{link.attr("href")}"
    end

    student_pages = links_array.collect do |link|
      begin
        Nokogiri::HTML(open(link))
      rescue OpenURI::HTTPError => error # if it don't
        if error.message == "404 Not Found"
          Nokogiri::HTML("http://students.flatironschool.com/#")
        else
          raise error
        end
      end
    end.compact

    students_array = []

    student_pages.each_with_index do |student_page, i|
      social_array = student_page.css("div.social-icons a").collect do |social_link|
        social_link.attr("href")
      end

      students_array[i] = {:student_id => i+1,
        :name => student_page.css("div.page-title h4").text, 
        :twitter_url => social_array[0],
        :linkedin_url => social_array[1],
        :facebook_url => social_array[3],
        :website_url => links_array[i]
      }
    end
    students_array
  end 

 

  
  
end
