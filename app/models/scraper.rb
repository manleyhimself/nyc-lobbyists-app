require "open-uri"
#step 1: figure out why you have 548 actions, when you should only have 38
class Scraper < ActiveRecord::Base

  @@client_and_lobbyist_arr = []
  @@client_address_arr = []

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
    arr = [] #remove
    i = 0 #remove
    collect_lobbyist_org_links.each do |link| #chagne back to map, and set equal to variable
      break if i == 5 #remove
      puts "#{link}"
      i += 1 #remove
      begin
        arr << Nokogiri::HTML(open(link)) #alter
      rescue OpenURI::HTTPError => error 
        if error.message == "404 Not Found"
          #empty for now
        else
          raise error
        end
      end
    end
    #arr #remove
    # end.compact -uncomment once map is put back in
    parse_pages(arr, collect_lobbyist_org_links) 
  end

  def parse_pages(array_before_parse, links_array)
    array_before_parse.each_with_index do |noko_obj, index|
      puts "organization: #{index + 1}"
      table_rows = return_nokogiri_table_rows(noko_obj)
      clients_and_lobbyists = return_nokogiri_clients_lobbyists(noko_obj) 
      client_address = return_nokogiri_client_address(noko_obj)
      @@client_and_lobbyist_arr = client_lobbyists_to_text(clients_and_lobbyists)
      @@client_address_arr = rows_to_text(client_address)
      collect_info_from_table_and_pages(rows_to_text(table_rows), links_array, index)
    end
  end

  def return_nokogiri_table_rows(noko_obj)
    noko_obj.xpath('/html/body/table/tr/td/table[3]/tr[4]/td[2]/table/tr/td')
  end

  def rows_to_text(rows_or_address_array)
    rows_or_address_array.map {|row| row.text }
  end

  def return_nokogiri_clients_lobbyists(noko_obj)
    noko_obj.css("td a")
  end

  def client_lobbyists_to_text(client_lobbyists_arr)
    client_lobbyists_arr.map {|row| row.text if row.attr("href").include?("search?")}[6..-1]
  end

  def return_nokogiri_client_address(noko_obj)
    noko_obj.css("span.table_text")
  end

  def find_or_create_action_clients_and_lobbyists_helper(firm_id, begin_date, end_date, purpose, payment, action_id) 
    action_specific_client_lobbyists = []
    @@client_and_lobbyist_arr.each do |client_or_lobbyist|
      break if client_or_lobbyist == nil
      action_specific_client_lobbyists << client_or_lobbyist.downcase
    end
    @@client_and_lobbyist_arr = @@client_and_lobbyist_arr[((@@client_and_lobbyist_arr.index(nil)) + 2)..-1]
    create_action(purpose, payment, begin_date, end_date, (create_client(action_specific_client_lobbyists)))
    create_lobbyists(action_specific_client_lobbyists, action_id, firm_id)
  end

  def create_action(purpose,payment, begin_date, end_date, client_id)
    Action.create(purpose: purpose, payment: payment, begin_date: begin_date, end_date: end_date, client_id: client_id)
  end

  def create_client(action_specific_client_lobbyists_arr)  #inc
    curr_client = Client.where(name: action_specific_client_lobbyists_arr[0], address: @@client_address_arr[0]).first_or_create
    @@client_address_arr.shift
    @@client_address_arr.shift
    curr_client.id
  end

  def create_lobbyists(action_specific_client_lobbyists_arr, action_id, firm_id)
    lobbyists_arr = action_specific_client_lobbyists_arr.map do |lobbyist|
      Lobbyist.where(name: lobbyist, firm_id: firm_id).first_or_create
    end
    lobbyists_arr.each do |lobbyist|
      LobbyistAction.create(action_id: action_id, lobbyist_id: lobbyist.id)
    end
  end

  def create_agencies(agency_purpose_payment_arr, action_id)
    agencies_arr = agency_purpose_payment_arr.map do |agency|
      Agency.where(name: agency).first_or_create
    end
    agencies_arr.each do |agency|
      AgencyAction.create(action_id: action_id, agency_id: agency.id)
    end
  end

  def parse_agency_purpose_payment(agency_purpose_payment_str)
    app_arr = agency_purpose_payment_str.split("Subject: ")
    agencies_arr = get_agencies(app_arr[0])
    agencies_arr = account_for_incon(agencies_arr)
    purpose_str = get_purpose(app_arr[1])
    payment = get_payment(app_arr[1])
    agency_purpose_payment_multi_arr = [] 
    agency_purpose_payment_multi_arr << agencies_arr
    agency_purpose_payment_multi_arr << purpose_str
    agency_purpose_payment_multi_arr << payment
  end

  def get_agencies(agencies_arr)
    agencies_arr.split("Target: ")[1].strip.gsub("and","|").gsub(",","|").split("|").map do |agency|
      agency.downcase!
      agency.strip
    end
  end

  def get_purpose(purpose_arr)
    purpose_arr.split("P1")[0].gsub("\r", "").gsub("\n", "").gsub("\t", "").split("  ").map do |x|
      next if x == ""
      x
    end.compact.map(&:strip).join(", ").gsub(", Compensation, Reimbursement", "")
  end

  def get_payment(payment_arr)
    payment_arr.split("P1")[1].split("Total")[1].gsub("\r", "").gsub("\n", "").gsub("\t", "").strip[1..-6].strip.to_f
  end

  def account_for_incon(agencies_arr)
    agencies_arr.map do |agency|
      if agency.include?("mayor") || agency.include?("otm")
        agency = "Office of the Mayor" 
      elsif agency.include?("dohmh") || agency.include?("mental hygiene")
        agency = "Department of Mental Hygiene" 
      elsif agency.include?("dsny") || agency.include?("sanitation")
        agency = "Department of Sanitation" 
      elsif agency.include?("(dot)") || agency.include?("transportation") || agency == "dot"
        agency = "Department of Transportation"
      elsif agency.include?("nycedc") || agency.include?("economic development")
        agency = "NYCEDC"
      elsif agency == "department of"
        agency = nil
      elsif agency.include?("education")
        agency = "Department of Education"
      else
        agency
      end
    end.compact.uniq
  end

  def collect_info_from_table_and_pages(main_rows_arr, links_array, links_array_index)
    element_index = 16
    page_iteration_num = 1
    curr_page_num = 1
    firm_name = main_rows_arr[16] #switch to levensthein on header, first element may not be right
    if main_rows_arr.last.include?("Page")
      rows = (main_rows_arr.last.split("1\n")[0].split("of ")[1].strip.to_i) * 15

      rows.times do |action_id|
        if page_iteration_num == 16
          element_index = 16
          page_iteration_num = 1
          curr_page_num += 1
          url = links_array[links_array_index] 

          page = Nokogiri::HTML(open(url + "&op=&pg_l=#{curr_page_num}"))

          main_rows_arr = rows_to_text(return_nokogiri_table_rows(page))

          break if main_rows_arr[element_index] != firm_name 

          @@client_and_lobbyist_arr = client_lobbyists_to_text(return_nokogiri_clients_lobbyists(page))

          @@client_address_arr = rows_to_text(return_nokogiri_client_address(page))
           
        end
        break if main_rows_arr[element_index] != firm_name 

          puts "row: #{action_id + 1}"
          puts "current page: #{curr_page_num}"
         
          curr_firm = Firm.where(name: main_rows_arr[element_index].downcase, address: main_rows_arr[element_index + 1]).first_or_create
          

          agency_purpose_payment_arr = parse_agency_purpose_payment(main_rows_arr[element_index + 7])

          create_agencies(agency_purpose_payment_arr[0], action_id)

          find_or_create_action_clients_and_lobbyists_helper(curr_firm.id, main_rows_arr[element_index + 4], main_rows_arr[element_index + 5], agency_purpose_payment_arr[1], agency_purpose_payment_arr[2], (action_id + 1))

        element_index += 8
        page_iteration_num += 1
      end
    else
      main_rows_arr.length.times do |action_id|
        break if main_rows_arr[element_index] != main_rows_arr[16] #switch to levensthein on header, first element may not be right

          puts "row: #{action_id + 1}"

          curr_firm = Firm.where(name: main_rows_arr[element_index].downcase, address: main_rows_arr[element_index + 1]).first_or_create

          agency_purpose_payment_arr = parse_agency_purpose_payment(main_rows_arr[element_index + 7])

          create_agencies(agency_purpose_payment_arr[0], action_id)

          find_or_create_action_clients_and_lobbyists_helper(curr_firm.id, main_rows_arr[element_index + 4], main_rows_arr[element_index + 5], agency_purpose_payment_arr[1], agency_purpose_payment_arr[2], (action_id + 1))

        element_index += 8
      end
    end
  end


   

    
  
end
