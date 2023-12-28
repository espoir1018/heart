class Hash

  def keys_sha1
    tmp = Digest::SHA1.hexdigest(self.keys.present? ? self.keys.join : [Time.now, rand(1..99)].join)
    tmp.number_to_char
  end

end