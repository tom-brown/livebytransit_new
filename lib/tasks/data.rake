desc 'upload neighborhood names and boundaries'
task :neighborhoods => :environment do

  Neighborhood.destroy_all
  HoodPoint.destroy_all

  require 'csv'
  
  CSV.foreach('chicago_hood_points.csv', :headers => true) do |row|
    n = Neighborhood.find_or_create_by(:name => row['pri_neigh'].titlecase) do |hood|
      hood.city_id = 1
      hood.save
    end
    HoodPoint.create(:neighborhood_id => n.id, :lat => row['Y'], :lng => row['X'])
    puts "#{n.name} HoodPoint created"
  end
end

desc 'find min lats and lngs for Neighborhoods'
task :neighborhood_minmax => :environment do
  
  lat_array = []
  lng_array = []
  Neighborhood.all.each do |n|
    n.hood_points.each do |point|
      lat_array << point.lat
      lng_array << point.lng
    end
    n.minlng = lng_array.min
    n.maxlng = lng_array.max
    n.minlat = lat_array.min
    n.maxlat = lat_array.max
    n.save
    p "#{n.name} minmax saved"
  end
end

desc 'parse cta_stations'
task :cta_stations => :environment do

  CtaLine.destroy_all
  CtaStation.destroy_all
  CtaAssign.destroy_all
  
  require 'csv'
  
  stations = ["Red", "Brown", "Blue", "Green", "Pink", "Yellow", "Orange", "Purple"]
  
  CSV.foreach('cta_trainstations.csv', :headers => true) do |row|
    if CtaStation.find_by_stop_id(row['STOP_ID'])
      next
    elsif
      CtaStation.find_by_lat(row['Location'].delete('()').split(',').first.strip)
      if CtaStation.find_by_lng(row['Location'].delete('()').split(',').last.strip)
        next
      end
    else
      a = CtaStation.create(stop_id: row['STOP_ID'], name: row['STATION_NAME'], lat: row['Location'].delete('()').split(',').first.strip.to_f, lng: row['Location'].delete('()').split.last.strip.to_f)
      p "#{a.name} station # #{a.stop_id} created with lat: #{a.lat} and lng: #{a.lng}"
      lines = row['STATION_DESCRIPTIVE_NAME'].split(" ")
      lines.each do |color|
        color = color.strip.gsub(/[^0-9a-z]/i, '')
        if stations.include? color
          b = CtaLine.find_or_create_by(name: color)
          CtaAssign.create(cta_station_id: a.id, cta_line_id: b.id)
          p color
        end
      end
    end
  end
end          

desc "Trying to find addresses for cta_stations"  #not working because stop_id does not line up with gtfs data
task find_cta_addresses: :environment do
  
    td_hash = {}
    filename = Rails.root + "cta_geojson.geojson"
    page = open(filename)
    parsed_json = JSON.parse(page.read)
    q = parsed_json['features'].map {|e| e['properties']['description'] }
    q.each do |station|
      doc = Nokogiri::HTML(station)
      td = doc.css("td")
      s_address = 0
      s_gtfs = 0
      key = ''
      value = ''
      td.each do |td|
        if s_address == 1
          value = td.text
          s_address = 0
        end
        if s_gtfs == 1
          key = td.text
          td_hash.store(key,value)
          s_gtfs = 0
        end
        if td.text == "ADDRESS"
          s_address = s_address + 1
        end
        if td.text == "GTFS"
          s_gtfs = s_gtfs + 1
        end
      end
      CtaStation.all.each do |station|
        station.address = td_hash["#{station.stop_id}"]
        station.save
        p station.address
      end
    end
end

desc "load metra train data from csv"
task :metra_trains => :environment do

MetraLine.destroy_all
MetraStation.destroy_all

  require 'csv'

  CSV.foreach('metra_stations_2012.csv', :headers => true, encoding: "UTF-8") do |row|
    lines = row['LINES'].split(",")
    lines.each do |line|
      line.strip!
      metra_line = MetraLine.find_or_create_by(name: line)
      puts "#{metra_line.name}"
      m = MetraStation.create(:name => row['LONGNAME'], :lat => row['ycoord'], :lng => row['xcoord'], :station_id => row['STATION_ID'].to_i)
      MetraAssign.create(metra_station_id: m.id, metra_line_id: metra_line.id)
      puts "#{m.name} created" 
    end 
  end
  
  puts "Just made #{MetraLine.count} Metraline records and #{MetraStation.count} Metrastation records! FUCK YEAH!!"

end

  