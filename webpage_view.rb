class WebpageView
	attr_reader :route, :ip
	@@collection = []

	class << self
		def all
			@@collection
		end

		def delete_all
			@@collection = []
		end

		def grouped_collection
			@@collection.group_by(&:route)
		end

		def views_count
			grouped_collection
				.collect { |key, value| { route: key, amount: value.collect(&:ip).count } }
				.sort_by { |h| h[:amount] }
				.reverse
		end

		def unique_views_count
			grouped_collection
				.collect { |key, value| { route: key, amount: value.collect(&:ip).uniq.count } }
				.sort_by { |h| h[:amount] }
				.reverse
		end
	end


	def initialize(route, ip)
		@route = route
		@ip = ip

		@@collection << self
	end
end