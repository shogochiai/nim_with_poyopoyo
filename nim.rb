# coding: utf-8
require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require './calc.rb'

num = []
puts "\n"
puts "うちの名前はぽよぽよだぽよ!"
sleep 2
puts "三山崩しをするぽよ!"
sleep 2
puts "一度に1から3つの石をとっていって、最後の石をとれた人の勝ちぽよ!"
sleep 2
puts "\n"
puts "\n"
puts "\n"
3.times do |i|
  puts "#{i+1}番目の石の数はいくつぽよ?"
  num[i] = gets.chomp.to_i
end


pp num
my_turn = true
puts "\n"
100.times do |i|
  rocks = ['', '', '']

  3.times do |j|
    num[j].times do
      rocks[j] += '*'
    end
    p rocks[j]
  end

  if num.sum > 0
    @user = my_turn ? 'あなた' : 'ぽよぽよ'
    puts "\n"
    p "#{i+1}ターン目 : #{@user}のターンですぽよ！"
    if my_turn
      # あなた
      p 'どの山から石をとりますかぽよ'
      mt = gets.chomp.to_i - 1
      p '石をいくつとりますかぽよ？'
      rid = gets.chomp.to_i
      num[mt] = num[mt] - rid
    else
      sleep 3
      # コンピューター
      mt_xor = num[0] ^ num[1] ^ num[2]
      l = 0
      3.times do |k|
        l = k if num[k] > num[k] ^ mt_xor
      end

      if l != 0
        num[l] ^= mt_xor
      else
        num[Calc.calc_max(num)[:id]] -= 1
      end
    end
    my_turn = !my_turn
  else
    break
  end
  puts "\n"
end

puts "#{@user}の勝ちぽよ！"
