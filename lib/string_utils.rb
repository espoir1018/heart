class String

  def number_to_char
    chars.map(&:to_chr).join
  end

  def to_chr
    is_integer? ? to_i.to_chr : self
  end

  # 判断是不是纯数字
  def is_integer?
    to_i.to_s == self
  end

end