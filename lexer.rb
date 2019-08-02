require 'bundler'
Bundler.setup
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
    :STOP,
    :DBAR,
    :BAR,
    :DAND,
    :AND,
    :STRING
  )

  rule(:PLUS,   /\+/)
  rule(:STOP,   /\./)
  rule(:DBAR,   /\A[||]*/)
  rule(:BAR,   /\|/) 
  rule(:DAND,   /\A[&&]*/)
  rule(:AND, /\&/) 
  rule(:SINGLEQ,   /\'/)
  rule(:DOUBLEQ,   /\"/)
  rule(:EQUALS,   /\=/)
  rule(:SEMIC,   /\;/)
  rule(:MINUS,  /\-/)
  rule(:WHITESPACE,  /\s/)
  rule(:OPERATOR,  /\*/)
  rule(:STRING,     /\A[_\$a-zA-Z][_\$0-9a-zA-Z]*/)
  rule(:IP, /(\d+(\.|$)){4}/)

  # SQL Keywords

  rule(:KEYWORD, /\b(SELECT|FROM|AND|WHERE)\b/)
 


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
