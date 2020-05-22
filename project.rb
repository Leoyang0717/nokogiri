# encoding: UTF-8
require 'sinatra'
require 'sinatra/reloader' if development?
require 'nokogiri'
require 'open-uri' #標準函式庫
require 'openssl'
require 'uri'
require "iconv" 

get '/' do

url = "https://apiservice.mol.gov.tw/OdService/rest/datastore/A17030000J-000049-Z0f";

ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')

doc = Nokogiri::HTML(
  ic.iconv(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read)
)

doc.css('body').each do |t|
math = t.text.gsub("/\/", " ").gsub("{"," ").gsub("}"," ").gsub(":"," ").gsub(","," ").gsub("]"," ").gsub("["," ").gsub('"'," ").split(" ")
@month = math.select {|x| x.include?("2019") || x.include?("2020")}
@dollor = math.select {|x| x.include?("幣") || x.include?("元") || x.include?("日") || x.include?("鎊")}.uniq
@rate = math.select {|x| x.include?(".")}
@rate1903 = @rate.slice(0..7)
@rate1904 = @rate.slice(8..15)
@rate1905 = @rate.slice(16..23)
@rate1906 = @rate.slice(24..31)
@rate1907 = @rate.slice(32..39)
@rate1908 = @rate.slice(40..47)
@rate1909 = @rate.slice(48..55)
@rate1910 = @rate.slice(56..63)
@rate1911 = @rate.slice(64..71)
@rate1912 = @rate.slice(72..79)
@rate2001 = @rate.slice(80..87)
@rate2002 = @rate.slice(88..95)
@rate2003 = @rate.slice(96..103)

end
  erb :index
end
