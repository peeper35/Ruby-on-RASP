require 'htmlentities'


class Patch
	def patchxss(sq)
		encoder = HTMLEntities.new
		encoder.encode(sq)	
	end
end


