def common_substrings(str1, str2)
	max_sub_str = ""
	i = 0
	while i <str1.length - 1
		z = i + 1
		while z < str1.length
			sub_str = str1[i..z]
			if str2.include?(sub_str) && sub_str.length > max_sub_str.length
				max_sub_str = sub_str
			end
			z+=1
		end
		i+=1
	end
	return max_sub_str
end
