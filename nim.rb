# coding: utf-8
require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require './calc.rb'

num = []
puts "\n"
puts "うちの名前はぽよぽよだぽよ!"
sleep 1.5
puts "三山崩しをするぽよ!"
sleep 1.5
puts "一度に1から3つの石をとっていって、最後の石をとれた人の勝ちぽよ!"
sleep 2.5
puts "\n"
puts "\n"
puts "\n"
3.times do |i|
  num[i] = (2..6).to_a.sample
end
puts "うちが山を作ってあげてるぽよ!"
sleep 2

puts "\n"

my_turn = [true, false].sample
puts my_turn ? 'あなたのターンからどうぞぽよ！' : 'うちのターンからいくぽよ！'
puts "\n"
sleep 1

100.times do |i|
  rocks = ['1: ', '2: ', '3: ']

  3.times do |j|
    num[j].times do
      rocks[j] += '*'
    end
    puts rocks[j]
  end

puts "\n"
sleep 1
  if num.sum > 0
    @user = my_turn ? 'あなた' : 'ぽよぽよ'
    puts "\n"
    puts "#{i+1}ターン目 : #{@user}のターンですぽよ！"
    if my_turn
      # あなた
      puts 'どの山から石をとりますかぽよ'
      mt = gets.chomp.to_i - 1
      puts '石をいくつとりますかぽよ？'
      rid = gets.chomp.to_i
      num[mt] = num[mt] - rid
      sleep 0.8
    else
      puts '考え中だぽよ'
      sleep 2
      # コンピューター
      mt_xor = num[0] ^ num[1] ^ num[2]
      l = 0
      3.times do |k|
        l = k if num[k] > num[k] ^ mt_xor
      end

      if l != 0 && 1 <= mt_xor && mt_xor <= 3
        num[l] ^= mt_xor
      else
        num[Calc.calc_max(num)[:id]] -= 1
      end
      sleep 2.5
    end
    my_turn = !my_turn
  else
    break
  end
  puts "\n"
end

puts "#{@user}の勝ちぽよ！"
