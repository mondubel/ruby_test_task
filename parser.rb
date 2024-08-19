require "./webpage_view"

filename = ARGV[0].to_s
return puts "No such file" unless File.file?(filename)

file = File.readlines(filename)
file.each do |line|
	route, ip = line.split
	WebpageView.new(route, ip)
end

puts "Webpages with most page views"
WebpageView.views_count.each do |vc| 
	puts "#{vc[:route]} #{vc[:amount]} visits"
end

puts "Webpages with most unique page views"
WebpageView.unique_views_count.each do |vc| 
	puts "#{vc[:route]} #{vc[:amount]} unique views"
end
