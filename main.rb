require 'singleton'
require_relative './ast'
require_relative './parser'

DATA_LAYOUT = 'target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"'.freeze

FUNC_START = 'define dso_local i32 @main() #0 {'.freeze
FUNC_END = '}'.freeze

EPILOGUE = <<~EPI.freeze
  attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

  !llvm.module.flags = !{!0}

  !0 = !{i32 1, !"wchar_size", i32 4}
EPI

class VariableCounter
  include Singleton
  attr_accessor :count

  def initialize
    @count = 0
  end

  def next
    @count += 1
    @count
  end
end

input = gets.chomp
ast = Parser.new.parse(input)

puts DATA_LAYOUT
puts FUNC_START
ast.generate
idx = VariableCounter.instance.next
puts "%#{idx} = load i32, i32* %#{idx-1}, align 4"
puts "ret i32 %#{idx}"
puts FUNC_END
puts EPILOGUE
