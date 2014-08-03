# coding: utf-8
require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require './calc.rb'

num = []

talk = lambda do |comment, args={}|
  args = {
    sleep_time: 0,
    before_num: 0,
    after_num: 0
  }.merge(args)

  ['before', 'after'].each do |stuck|
    new_line = ""
    args["#{stuck}_num".to_sym].times do
      new_line += "\n"
    end
    instance_variable_set("@#{stuck}_line", new_line)
  end
  puts @before_line + comment + @after_line
  sleep args[:sleep_time]
end

serif = {
  introduction: {comment: "うちの名前はぽよぽよだぽよ!", sleep_time: 1.5, before_time: 1, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0},
  a: {comment: "", sleep_time: 0, before_time: 0, after_time: 0}
}


talk.call("うちの名前はぽよぽよだぽよ!", sleep_time: 1.5, before_num: 1)
talk.call("三つの山から石をとっていくゲームをするぽよ!", sleep_time: 1.5)
talk.call("一度に1から3つの石をとっていって、最後の石をとれた人の勝ちぽよ!", sleep_time: 2.5, after_num: 3)

my_turn = [true, false].sample
start_comment = my_turn ? "今回はあなたのターンからどうぞぽよ!" : "うちのターンからいくぽよ!"
talk.call(start_comment, sleep_time: 1, after_num: 1)


3.times { |i| num[i] = (4..8).to_a.sample }
puts "うちが山を作ってあげてるぽよ!"; sleep 2; puts "\n"
talk.call(start_comment, sleep_time: 1, after_num: 1)

100.times do |i|
  mountains = ['1: ', '2: ', '3: ']

  3.times do |j|
    num[j].times do
      mountains[j] += '*'
    end
    puts mountains[j]
  end
  puts "\n"; sleep 1

  if num.sum > 0
    @user = my_turn ? "あなた" : "ぽよぽよ"
    puts "\n#{i+1}ターン目 : #{@user}のターンですぽよ！"
    if my_turn
      puts 'どの山から石をとりますかぽよ'
      selected_mountain = gets.chomp.to_i - 1
      puts '石をいくつとりますかぽよ？'
      remove_stone = gets.chomp.to_i
      num[selected_mountain] = num[selected_mountain] - remove_stone
      sleep 0.8
    else
      case num.sum
      when 1
        puts 'いただくぽよ!!'
      when 2
        puts 'ふむふむぽよ〜!'
      when 3
        puts 'ふふふぽよ!'
      when 4
        puts 'おもしろいぽよ!'
      when 5
        puts 'ふーむ、ぽよ!'
      when 6
        puts '読めてきたぽよ!'
      when 7
        puts 'きたきたぽよ!'
      when 8
        puts 'むむむぽよ!'
      else
        puts '考えてるぽよ...!'
      end; sleep 2

      # 排他的論理和による必勝アルゴリズム
      mt_xor = num[0] ^ num[1] ^ num[2]
      l = 0
      3.times { |k| l = k if num[k] > num[k] ^ mt_xor }

      # 必勝パターンに当てはまらなければ最大の山から1だけ取って相手のミスを待つ
      if l != 0 && 1 <= mt_xor && mt_xor <= 3
        num[l] ^= mt_xor
      else
        num[Calc.calc_max(num)[:id]] -= 1
      end; sleep 2.5
    end
    my_turn = !my_turn
  else
    break
  end
end

puts "\n#{@user}の勝ちぽよ！"
