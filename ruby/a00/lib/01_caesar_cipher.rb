def caesar_cipher(str, shift)
	alphabet = ("a".."z").to_a
	return str.split("").collect! {|i|
		if i != " "
			o_index = alphabet.index(i)
			sum = o_index + shift
			n_index = sum > 25 ? sum - 26 : sum
			val = alphabet[n_index]
		else
			val = " "
		end
	}.join("")
end
