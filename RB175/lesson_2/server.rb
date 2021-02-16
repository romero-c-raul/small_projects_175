require "socket"

def obtain_request_components(string)
  method, path_and_parameters = string.split(" ")
  path, parameters = path_and_parameters.split("?")

  key_value_pairs = (parameters || "").split("&").map do |current_pair|
    current_pair.split("=")
  end.to_h

  [method, path, key_value_pairs]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  next unless request_line

  http_method, path, params = obtain_request_components(request_line)

  client.puts "HTTP/1.1 200 OK"           # Tells us if request was processed succesfully
  client.puts "Content-Type: text/html"   # Determines how to display response
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Rolls!</h1>"
  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  1.upto(rolls) do
    roll = rand(sides) + 1
    client.puts "<p>", roll, "</p>"
  end

  client.puts "</body>"
  client.puts "</html>"

  client.close
end

#PEDAC for Parsing through request line
=begin

  input: string
  output: string, string, hash

  rules
    - Explicit rules:
      - Separate given string into three different sections
        - Method
        - Path
        - Parameters

        - To obtain method
          - Split string by spaces and obtain first element
        - To obtain path and params
          - Second element must be split by question mark
            - This gives us path and parameter elements
        - To obtain hash from params
          - Separate string by "&"
            - This gives you strings that consist of key=value
              - Separate by "=" to obtain key value pairs

=end
