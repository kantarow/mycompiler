#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.6.0
# from Racc grammar file "".
#

require 'racc/parser.rb'
class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 19)

def parse(text)
  @chars = text.chars
  do_parse
end

def next_token
  c = @chars.shift
  if c =~ /[0-9]/
    buf = c
    while (c = @chars.shift) && c =~ /[0-9]/
      buf << c
    end
    @chars.unshift(c)
    [:INTEGER, buf.to_i]
  elsif c =~ /\s/
    next_token
  elsif c == nil
    [false, nil]
  else
    [c, nil]
  end
end

def on_error(*args)
  puts 'ng'
end

...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
     9,    10,     7,     8,     6,    18,     3,     4,    13,     5,
     9,    10,     7,     8,     3,     4,   nil,     5,     3,     4,
   nil,     5,     3,     4,   nil,     5,     3,     4,   nil,     5,
     3,     4,   nil,     5,     3,     4,   nil,     5,     9,    10,
     9,    10,     9,    10 ]

racc_action_check = [
    12,    12,    12,    12,     1,    12,     0,     0,     6,     0,
     2,     2,     2,     2,     3,     3,   nil,     3,     4,     4,
   nil,     4,     7,     7,   nil,     7,     8,     8,   nil,     8,
     9,     9,   nil,     9,    10,    10,   nil,    10,    11,    11,
    14,    14,    15,    15 ]

racc_action_pointer = [
     1,     4,     8,     9,    13,   nil,     8,    17,    21,    25,
    29,    36,    -2,   nil,    38,    40,   nil,   nil,   nil ]

racc_action_default = [
    -2,   -10,    -1,   -10,   -10,    -9,   -10,   -10,   -10,   -10,
   -10,    -7,   -10,    19,    -3,    -4,    -5,    -6,    -8 ]

racc_goto_table = [
     2,     1,   nil,    11,    12,   nil,   nil,    14,    15,    16,
    17 ]

racc_goto_check = [
     2,     1,   nil,     2,     2,   nil,   nil,     2,     2,     2,
     2 ]

racc_goto_pointer = [
   nil,     1,     0 ]

racc_goto_default = [
   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 10, :_reduce_none,
  0, 10, :_reduce_none,
  3, 11, :_reduce_3,
  3, 11, :_reduce_4,
  3, 11, :_reduce_5,
  3, 11, :_reduce_6,
  2, 11, :_reduce_7,
  3, 11, :_reduce_8,
  1, 11, :_reduce_9 ]

racc_reduce_n = 10

racc_shift_n = 19

racc_token_table = {
  false => 0,
  :error => 1,
  "*" => 2,
  "/" => 3,
  "+" => 4,
  "-" => 5,
  "(" => 6,
  ")" => 7,
  :INTEGER => 8 }

racc_nt_base = 9

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "\"*\"",
  "\"/\"",
  "\"+\"",
  "\"-\"",
  "\"(\"",
  "\")\"",
  "INTEGER",
  "$start",
  "target",
  "exp" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

module_eval(<<'.,.,', 'parser.y', 8)
  def _reduce_3(val, _values, result)
     result = AST::Add.new(val[0], val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 9)
  def _reduce_4(val, _values, result)
     result = AST::Sub.new(val[0], val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 10)
  def _reduce_5(val, _values, result)
     result = AST::Mul.new(val[0], val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_6(val, _values, result)
     result = AST::Div.new(val[0], val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 12)
  def _reduce_7(val, _values, result)
     result = AST::Minus.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 13)
  def _reduce_8(val, _values, result)
     result = AST::Brachet.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 14)
  def _reduce_9(val, _values, result)
     result = AST::Integer.new(val[0])
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser


if $0 == __FILE__
  $stdin.each_line do |line|
    pp Parser.new.parse(line)
  end
end
