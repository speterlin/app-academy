def fibs(num)
	if num == 0
		return []
	elsif num == 1
		return fibs(num-1) << 0
	elsif num == 2
		return fibs(num-1) << 1
	else
		sum = fibs(num-2)[-1] + fibs(num-1)[-1]
		return fibs(num-1) << sum
	end
end
