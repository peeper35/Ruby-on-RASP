require 'lex'

class MyLexer < Lex::Lexer
  tokens(
    :NUMBER,
    :PLUS,
    :MINUS,
    :OPERATOR,
    :EQUALS,
    :WHITESPACE,
    :KEYWORD,
    :NEWLINE,
    :SEMIC,
    :SINGLEQ,
    :DOUBLEQ,
    :IP,
    :DOMAIN,
    :STRING
  )

  rule(:PLUS,   /\+/)
  rule(:SINGLEQ,   /\'/)
  rule(:DOUBLEQ,   /\"/)
  rule(:EQUALS,   /\=/)
  rule(:SEMIC,   /\;/)
  rule(:MINUS,  /\-/)
  rule(:WHITESPACE,  /\s/)
  rule(:OPERATOR,  /\*/)
  rule(:STRING,     /\A[_\$a-zA-Z][_\$0-9a-zA-Z]*/)
  rule(:IP, /(\d+(\.|$)){4}/)
  rule(:DOMAIN, /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,7}$/)

  # SQL Keywords

  rule(:KEYWORD, /\b(SELECT|FROM|AND|WHERE|UNION|SELECT|ORDER|BY|OR)\b/)
 


  rule(:NUMBER, /[0-9]+/) do |lexer, token|
    token.value = token.value.to_i
    token
  end

  rule(:NEWLINE, /\n+/) do |lexer, token|
    lexer.advance_line(token.value.length)
  end
end

def takein(inp)
    tokens = Array.new
    output = MyLexer.new.lex(inp)

    output.each do |op|
        tokens << op
    end
    return tokens.inspect.tr(':', '')

end
