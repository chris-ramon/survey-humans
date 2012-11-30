class Student < ActiveRecord::Base
	belongs_to :course

	def self.can_see_graph(course)
		students=Student.where(:course_id=>course.id)
		can=true
		students.each do |st|
			can=false if st.corrects==nil
		end
		can
	end
end
