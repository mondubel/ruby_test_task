require "minitest/autorun"
require "./webpage_view"

class TestWebpageView < Minitest::Test
	def setup
		file = File.readlines('tests.log')
		file.each do |line|
			route, ip = line.split
			WebpageView.new(route, ip)
		end
	end

	def teardown
		WebpageView.delete_all
	end

	def test_all
		assert_equal 12, WebpageView.all.count
	end

	def test_delete_all
		WebpageView.delete_all
		assert_equal 0, WebpageView.all.count
	end

	def test_grouped_collection
		assert_equal 3, WebpageView.grouped_collection.count
		assert_includes WebpageView.grouped_collection.keys, "/index"
		assert_includes WebpageView.grouped_collection.keys, "/about"
		assert_includes WebpageView.grouped_collection.keys, "/help"
	end

	def test_views_count
		assert_equal 3, WebpageView.views_count.count
		assert_equal "/about", WebpageView.views_count.first[:route]
		assert_equal 6, WebpageView.views_count.first[:amount]
	end

	def test_unique_views_count
		assert_equal 3, WebpageView.unique_views_count.count
		assert_equal "/index", WebpageView.unique_views_count.first[:route]
		assert_equal 3, WebpageView.unique_views_count.first[:amount]
	end
end