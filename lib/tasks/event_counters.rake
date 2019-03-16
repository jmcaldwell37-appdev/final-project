task :freezing_counter => :environment do
require 'open-uri'
CustomizedPreference.where(:event_id => "#{Event.first.id}").each do |preference|
      
  @street_address = User.find_by(id: preference.user_id).location
    sanitized_street_address = URI.encode(@street_address)

url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{sanitized_street_address.to_s}&key=AIzaSyBr-0XDfztIIUGyPRfa1D5KfPvURvAk2e4"
parsed_data = JSON.parse(open(url).read)
latitude = parsed_data.dig("results", 0, "geometry", "location", "lat")
longitude = parsed_data.dig("results", 0, "geometry", "location", "lng")

url_dos = "https://api.darksky.net/forecast/8707954d64e5b10beab32c74ed9d5927/#{latitude.to_s},#{longitude.to_s}"
parsed_data_dos = JSON.parse(open(url_dos).read)

    # @current_temperature = parsed_data_dos.dig("currently","temperature").to_i
    
@daily_low = parsed_data_dos.dig("daily","data",0,"temperatureLow").to_i

  if @daily_low < 32
      @total= Goal.find_by(id: preference.goal_id).current_amount.to_i
      @total= @total + preference.transaction_amount.to_f
      @total= @total.to_s
      @a=Goal.find_by(id: preference.goal_id)
      @a.current_amount= @total
      @a.save
      
    else
  end
  end
end

  # Created an array which, with each rake call, will have current totalCount appended to end, thus allowing for a differential boolean operator
  @countDiffArray = [3025]
  
task :disaster_counter => :environment do 
  require 'open-uri'
  
CustomizedPreference.where(:event_id => "#{Event.find_by(:name => "ReliefWeb declares a natural disaster").id}").each do |preference|
  
dwurl = "https://api.reliefweb.int/v1/disasters?appname=disaster_counter&profile=list&preset=latest"
parsed_dw_data = JSON.parse(open(dwurl).read)

@totalCount = parsed_dw_data.dig("totalCount")
@countDiffArray.insert(-1,@totalCount)

  if @countDiffArray[-1] - @countDiffArray[-2] > 0
      @total= Goal.find_by(id: preference.goal_id).current_amount.to_i
      @total= @total + preference.transaction_amount.to_f
      @total= @total.to_s
      @a=Goal.find_by(id: preference.goal_id)
      @a.current_amount= @total
      @a.save
    else
  end
  
  end
end

@winsDiffArray= [5252]

task :win_counter => :environment do
  require 'open-uri'
  
CustomizedPreference.where(:event_id => "#{Event.find_by(:name => "the Bucks win a game").id}").each do |preference|

  
url = "https://www.nba.com/bucks/stats/team"
page = HTTParty.get(url) 

  # filename = Rails.root.join("lib", "espn", "bucks-scores.html")
  # page = open(filename)

  doc = Nokogiri::HTML(page)
  
@wins = doc.css("tr:nth-child(7) .gp").text.to_i

@winsDiffArray.insert(-1, @wins)

if @winsDiffArray[-1] - @winsDiffArray[-2] > 0
      @total= Goal.find_by(id: preference.goal_id).current_amount.to_i
      @total= @total + preference.transaction_amount.to_f
      @total= @total.to_s
      @a=Goal.find_by(id: preference.goal_id)
      @a.current_amount= @total
      @a.save
    else
end
end
end

# Now just tailor each to the actual amounts of each transaction