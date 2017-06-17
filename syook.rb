require 'pry'
require 'celluloid/current'
require 'httparty'
class Syook
	include Celluloid
	def ping(card_no)
		card  = card_no
		reader_ids = (0...20).to_a
		reader_id = (0...20).to_a.sample # 20 cards
		random_no = [1,2,3,4,5,6,7] # random number of pings for one card
		pings = random_no.sample
		k = 0
		i = 1
		max = 100
		min = 80
		strength = (min..max).to_a.sample.to_s
		r_id = l_id = reader_id
		pings.times do 
			time = Time.now.strftime("%I:%M:%S").to_s
			str = "#{card}_#{reader_id}_#{strength}_#{time}\n"
			if k % 2 == 0
				sum = r_id + 1
				if sum > 19
					reader_id = reader_ids[sum % 2]
					min -= 10
					max -= 10
				else
					reader_id = reader_id + i
					if reader_id > 19
						reader_id = reader_ids[reader_id - 19]
					end
					min -= 10
					max -= 10	
				end	
				r_id = reader_id
				i += 1
				strength = (min..max).to_a.sample.to_s
			else
				diff = l_id - 1
				if diff <= 0
					#binding.pry
					reader_id = reader_ids[diff]
					#binding.pry
					min -= 10
					max -= 10
				else
					reader_id = reader_id - i
					if reader_id < 0
						reader_id = reader_ids[reader_id]
					end
					min -= 10
					max -= 10
				end
				l_id -= 1
				i += 1
				strength = (min..max).to_a.sample.to_s
			end
			k += 1
			str1 = "?str=#{str}"
			HTTParty.post('http://localhost:3000/traces'+str1) #ping goes from here before the 10 second time interval
			sleep(1.0/1.5)
		end
	end
end

while true
(0...100).each do |card| #for 100 cards 
	t = Syook.new
	t.async.ping(card)
	sleep(1.0)
end
sleep(10.0)
end
#terminate this using ctrl-c