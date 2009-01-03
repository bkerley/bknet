class Post < ActiveRecord::Base
	has_and_belongs_to_many :tags
	validates_format_of :slug, :with=>/^([\d\w-])*$/
	validates_presence_of :slug, :title
	validates_uniqueness_of :slug, :title
	
	def tag_string=(tag_string)
		individual_tags = tag_string.split " "
		tag_models = individual_tags.map do |t|
			Tag.find_or_create_by_title t
		end
		self.tags = tag_models
	end
	
	def tag_string
		if self.tags.length == 0
			"no tags yet"
		else
			self.tags.map(&:title).join(" ")
		end
	end
	
	def abbreviated?
		self.excerpt
	end
	
	def abbreviated
		unless abbreviated?
			self.body
		else
			self.excerpt 
		end
	end
	
	def entire
		if abbreviated?
			self.excerpt + self.body
		else
			self.body
		end
	end
end
