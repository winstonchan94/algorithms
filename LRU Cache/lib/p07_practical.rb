require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  xd_lul = string.split("").permutation.to_a
  xd_lul.each do |perm|
    bob = perm.join
    if bob.reverse == bob
      return true
    end
  end
  return false
end
