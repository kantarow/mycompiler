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

  class Minus
    def initialize(exp)
      @exp = exp
    end

    def generate
      @exp.generate
      exp_idx = VariableCounter.instance.next
      result_idx = VariableCounter.instance.next
      store_idx = VariableCounter.instance.next
      puts "%#{exp_idx} = load i32, i32* %#{exp_idx-1}, align 4"
      puts "%#{result_idx} = sub i32 0, %#{exp_idx}"
      puts "%#{store_idx} = alloca i32, align 4"
      puts "store i32 %#{result_idx}, i32* %#{store_idx}"
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
      puts "%#{idx} = add i32 %#{left_result_idx}, %#{right_result_idx}"
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 %#{idx-1}, i32* %#{idx}, align 4"
    end
  end

  class Sub < BinaryOp
    def generate
      @left.generate
      left_result_idx = VariableCounter.instance.next
      puts "%#{left_result_idx} = load i32, i32* %#{left_result_idx-1}, align 4"

      @right.generate
      right_result_idx = VariableCounter.instance.next
      puts "%#{right_result_idx} = load i32, i32* %#{right_result_idx-1}, align 4"

      idx = VariableCounter.instance.next
      puts "%#{idx} = sub i32 %#{left_result_idx}, %#{right_result_idx}"
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 %#{idx-1}, i32* %#{idx}, align 4"
    end
  end

  class Mul < BinaryOp
    def generate
      @left.generate
      left_result_idx = VariableCounter.instance.next
      puts "%#{left_result_idx} = load i32, i32* %#{left_result_idx-1}, align 4"

      @right.generate
      right_result_idx = VariableCounter.instance.next
      puts "%#{right_result_idx} = load i32, i32* %#{right_result_idx-1}, align 4"

      idx = VariableCounter.instance.next
      puts "%#{idx} = mul i32 %#{left_result_idx}, %#{right_result_idx}"
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 %#{idx-1}, i32* %#{idx}, align 4"
    end
  end

  class Div < BinaryOp
    def generate
      @left.generate
      left_result_idx = VariableCounter.instance.next
      puts "%#{left_result_idx} = load i32, i32* %#{left_result_idx-1}, align 4"

      @right.generate
      right_result_idx = VariableCounter.instance.next
      puts "%#{right_result_idx} = load i32, i32* %#{right_result_idx-1}, align 4"

      idx = VariableCounter.instance.next
      puts "%#{idx} = sdiv i32 %#{left_result_idx}, %#{right_result_idx}"
      idx = VariableCounter.instance.next
      puts "%#{idx} = alloca i32, align 4"
      puts "store i32 %#{idx-1}, i32* %#{idx}, align 4"
    end
  end

  class Brachet
    attr_accessor :exp

    def initialize(exp)
      @exp = exp
    end

    def generate
      exp.generate
    end
  end
end
