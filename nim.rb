# coding: utf-8
require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require './calc.rb'

num = []

talk = ->(args={}){
  args = {
    comment: "",
    sleep_time: 0,
    before_time: 0,
    after_time: 0
  }.merge(args)

  ['before', 'after'].each do |stuck|
    new_line = ""
    args["#{stuck}_time".to_sym].times do
      new_line += "\n"
    end
    instance_variable_set("@#{stuck}_line", new_line)
  end
  puts @before_line + args[:comment] + @after_line
  sleep args[:sleep_time]
}

define_reply = ->(sum){
  case sum
  when 1
    'いただくぽよ!!'
  when 2
    'ふむふむぽよ〜!'
  when 3
    'ふふふぽよ!'
  when 4
    'おもしろいぽよ!'
  when 5
    'ふーむ、ぽよ!'
  when 6
    '読めてきたぽよ!'
  when 7
    'きたきたぽよ!'
  when 8
    'むむむぽよ!'
  else
    '考えてるぽよ...!'
  end
}

calc_max = ->(num){
  max = num.max
  max_hash = {}
  num.each.with_index(1) do |value, i|
    if value == max
      max_hash[:id] = i - 1
      max_hash[:max] = max
    end
  end
  if max_hash.empty?
    max_hash[:id] = nil
    max_hash[:max] = nil
    max_hash
  else
    return max_hash
  end
}

serif = {
  introduction: {comment: "うちの名前はぽよぽよだぽよ!", sleep_time: 1.5, before_time: 1, after_time: 0},
  explain1: {comment: "三つの山から石をとっていくゲームをするぽよ!", sleep_time: 1.5, before_time: 0, after_time: 0},
  explain2: {comment: "一度に1から3つの石をとっていって、最後の石をとれた人の勝ちぽよ!", sleep_time: 2.5, before_time: 0, after_time: 3},
  turn: {comment: "", sleep_time: 1, before_time: 0, after_time: 1},
  create_mountain: {comment: "うちが山を作ってあげてるぽよ!", sleep_time: 2, before_time: 0, after_time: 1},
  mountain0: {comment: "", sleep_time: 0, before_time: 0, after_time: 1},
  mountain1: {comment: "", sleep_time: 0, before_time: 0, after_time: 1},
  mountain2: {comment: "", sleep_time: 0, before_time: 0, after_time: 1},
  get_anounce: {comment: "", sleep_time: 2.5, before_time: 0, after_time: 1},
  routine_talk: {comment: "", sleep_time: 0, before_time: 0, after_time: 2},
  your_turn: {comment: "", sleep_time: 1, before_time: 1, after_time: 0},
  which_mountain: {comment: "どの山から石をとりますかぽよ", sleep_time: 0, before_time: 0, after_time: 0},
  how_many_stone: {comment: "石をいくつとりますかぽよ？", sleep_time: 0.8, before_time: 0, after_time: 0}
}


talk.call(serif[:introduction])
talk.call(serif[:explain1])
talk.call(serif[:explain2])

my_turn = [true, false].sample
serif[:turn][:comment] = my_turn ? "今回はあなたのターンからどうぞぽよ!" : "うちのターンからいくぽよ!"
talk.call(serif[:turn])

3.times { |i| num[i] = (4..8).to_a.sample }
talk.call(serif[:create_mountain])

100.times do |i|
  mountains = ['1: ', '2: ', '3: ']

  3.times do |j|
    num[j].times do
      mountains[j] += '*'
    end
    serif["mountain#{j}".to_sym][:comment] = mountains[j]
    talk.call(serif["mountain#{j}".to_sym])
  end

  if num.sum > 0
    @user = my_turn ? "あなた" : "ぽよぽよ"
    serif[:your_turn][:comment] = "#{i+1}ターン目 : #{@user}のターンですぽよ！"
    talk.call(serif[:your_turn])
    if my_turn
      talk.call(serif[:which_mountain])
      selected_mountain = gets.chomp.to_i - 1
      talk.call(serif[:how_many_stone])
      remove_stone = gets.chomp.to_i
      num[selected_mountain] = num[selected_mountain] - remove_stone
    else
      serif[:routine_talk][:comment] = define_reply.call(num.sum)
      talk.call(serif[:routine_talk])

      # 排他的論理和によるほぼ必勝アルゴリズム
      mt_xor = num[0] ^ num[1] ^ num[2]
      l = 0
      3.times { |k| l = k if num[k] > num[k] ^ mt_xor }

      # 必勝パターンに当てはまらなければ最大の山から1だけ取って相手のミスを待つ
      # うまくやればコンピューターはこの処理だけを行うのだが、人間にとってそれは運でしかない
      if l != 0 && 1 <= mt_xor && mt_xor <= 3
        before_num = num
        num[l] ^= mt_xor
        3.times do |i|
          if diff = before_num[i] - num[i] != 0
            serif[:get_anounce][:comment] = "#{i+1}番目の山から, #{diff}個の石を取ったぽよ!"
            break
          end
        end
      else
        i, diff = calc_max.call(num)[:id], 1
        num[i] -= diff
        serif[:get_anounce][:comment] = "#{i+1}番目の山から, #{diff}個の石を取ったぽよ!"
      end
      talk.call(serif[:get_anounce])
    end
    my_turn = !my_turn
  else
    break
  end
end

puts "\n#{@user}の勝ちぽよ！"
