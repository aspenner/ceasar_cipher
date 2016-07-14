require 'sinatra'
require 'sinatra/reloader'

UPPER_CASE = ('A'.ord .. 'Z'.ord)
LOWER_CASE = ('a.'.ord .. 'z'.ord)

def ceaser_cipher(message, shift)
	encrypted = ""
	message.each_char do |c|
		ascii_val = c.ord
		if UPPER_CASE.include?(ascii_val) then
			encrypted << (((ascii_val - UPPER_CASE.min + shift) % 26) + UPPER_CASE.min).chr
		elsif LOWER_CASE.include?(ascii_val) then
			encrypted << (((ascii_val - LOWER_CASE.min + shift) % 26) + LOWER_CASE.min).chr
		else
			encrypted << c
		end
	end
	return encrypted
end

get '/' do
  message = params["message"]
  shift = params["shift"].to_i
	unless message.nil? || shift == 0
  	encrypted_message = ceaser_cipher(message, shift)
	end
  erb :index, :locals => {:encrypted_message => encrypted_message}
end
