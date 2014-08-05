require 'nokogiri'
require 'rest-client'

done = false

start = 1
requests = 0

CLASSES_URL = 'https://www.witcc.edu/classes/index.cfm?start='

start_time = Time.now

while not done do

	url = "#{CLASSES_URL}#{start}"

	page = Nokogiri::HTML(RestClient.get(url))
	requests += 1

	courses = page.css('#classesDisplay div')

	courses.each do |course|

		course_data = course.css('h3 a')
		id = course_data.css('.courseID').text
		title = course_data.css('.courseTitle').text
		dates = course_data.css('.courseDates').text
		campus = course_data.css('.courseCampus').text

		description = course.css('div.ui-accordion-content').text

		puts "#{id} #{title} #{dates} #{campus}"

	end

	start += 50

	done = courses.count == 0

end

end_time = Time.now
elapsed = end_time - start_time

puts "#{requests} requests"
puts "#{elapsed} sec"