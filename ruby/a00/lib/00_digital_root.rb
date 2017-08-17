def digital_root_step(num)
	dig = num %10
	rem = num/10
	if rem<1
		return dig
	else
		return dig + digital_root(rem)
	end	
end

def digital_root(num)
	while num/10 >= 1
		num = digital_root_step(num)
	end
	return num
end