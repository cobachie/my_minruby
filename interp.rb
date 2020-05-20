require 'minruby'

def evaluate(tree, genv, lenv)
  case tree[0]
  when 'lit'
    tree[1]
  when '+'
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when '-'
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when '*'
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when '/'
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when '%'
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when '=='
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when '<'
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when '>'
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when '<='
    evaluate(tree[1], genv, lenv) <= evaluate(tree[2], genv, lenv)
  when '>='
    evaluate(tree[1], genv, lenv) >= evaluate(tree[2], genv, lenv)
  when 'stmts'
    # 複文対応
    i = 1
    last = nil
    while tree[i]
      last = evaluate(tree[i], genv, lenv)
      i = i + 1
    end
    last
  when 'var_assign'
    # 変数代入
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when 'var_ref'
    # 変数参照
    lenv[tree[1]]
  when 'func_call'
    # p evaluate(tree[2], genv, lenv)
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'builtin'
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      params = mhd[1]
      i = 0
      while params[i]
        new_lenv[params[i]] = args[i]
        i = i + 1
      end
      evaluate(mhd[2], genv, new_lenv)
    end
  when 'if'
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when 'while'
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when 'while2'
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when 'func_def'
    genv[tree[1]] = ["user_defined", tree[2], tree[3]]
  when 'ary_new'
    ary = []
    i = 0
    while tree[i + 1]
      ary[i] = evaluate(tree[i + 1], genv, lenv)
      i = i + 1
    end
    ary
  when 'ary_ref'
    ary = evaluate(tree[1], genv, lenv)
    idx = evaluate(tree[2], genv, lenv)
    ary[idx]
  when 'ary_assign'
    ary = evaluate(tree[1], genv, lenv)
    idx = evaluate(tree[2], genv, lenv)
    val = evaluate(tree[3], genv, lenv)
    ary[idx] = val
  when 'hash_new'
    hsh = {}
    i = 0
    while tree[i + 1]
      key = evaluate(tree[i + 1], genv, lenv)
      val = evaluate(tree[i + 2], genv, lenv)
      hsh[key] = val
      i = i + 2
    end
    hsh
  end
end

# 計算式の文字列を読み込む
str = minruby_load()

# 計算式の文字列を構文解析して計算の木になる
tree = minruby_parse(str)
pp tree

# 計算の木を実行（計算）する
genv = {
  'p' => ['builtin', 'p'],
  'pp' => ['builtin', 'pp'],
  'require' => ['builtin', 'require'],
  'minruby_load' => ['builtin', 'minruby_load'],
  'minruby_parse' => ['builtin', 'minruby_parse'],
  'minruby_call' => ['builtin', 'minruby_call'],
}
lenv = {}
answer = evaluate(tree, genv, lenv)
