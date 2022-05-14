class Parser
  prechigh
    left '*' '/'
    left '+' '-'
  preclow
rule
  target: exp
        |
  exp : exp '+' exp { result = AST::Add.new(val[0], val[2]) }
      | exp '-' exp { result = AST::Sub.new(val[0], val[2]) }
      | exp '*' exp { result = AST::Mul.new(val[0], val[2]) }
      | exp '/' exp { result = AST::Div.new(val[0], val[2]) }
      | '-' exp { result = AST::Minus.new(val[1]) }
      | '(' exp ')' { result = AST::Brachet.new(val[1]) }
      | INTEGER { result = AST::Integer.new(val[0]) }
end

---- inner

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

---- footer

if $0 == __FILE__
  $stdin.each_line do |line|
    pp Parser.new.parse(line)
  end
end
