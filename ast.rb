module AST
  class Integer
    def initialize(val)
      @val = val
    end

    def generate
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 #{@val}, i32* %#{idx}, align 4"
    end
  end

  class BinaryOp
    attr_accessor :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end
  end

  class Add < BinaryOp
    def generate
      @left.generate
      left_result_idx = VariableCounter.instance.next
      puts "%#{left_result_idx} = load i32, i32* %#{left_result_idx-1}, align 4"

      @right.generate
      right_result_idx = VariableCounter.instance.next
      puts "%#{right_result_idx} = load i32, i32* %#{right_result_idx-1}, align 4"

      idx = VariableCounter.instance.next
      puts "%#{idx} = add nsw i32 %#{left_result_idx}, %#{right_result_idx}"
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 %#{idx-1}, i32* %#{idx}, align 4"
    end
  end

  class Sub < BinaryOp
  end

  class Mul < BinaryOp
  end

  class Div < BinaryOp
  end

  class Brachet
    attr_accessor :exp

    def initialize(exp)
      @exp = exp
    end
  end
end
