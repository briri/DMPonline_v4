class GuidanceGroup < ActiveRecord::Base
  	attr_accessible :organisation_id, :name, :default

	#associations between tables
	belongs_to :organisation
	has_and_belongs_to_many :guidances, join_table: "guidance_in_group"
	has_and_belongs_to_many :projects, join_table: "project_guidance"
	
	def to_s
		"#{display_name}"
	end
	
	def display_name
		if organisation.guidance_groups.count > 1
			return "#{organisation.name}: #{name}"
		else
			return organisation.name
		end
	end
	
	def self.guidance_groups_excluding(excluded_orgs)
		excluded_org_ids = Array.new
		excluded_orgs.each do |org|
			excluded_org_ids << org.id
		end
		return GuidanceGroup.where("organisation_id NOT IN (?)", excluded_org_ids)
	end
	
end
