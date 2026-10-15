#! /bin/lua5.4

local socket = require "socket"

server=assert(socket.tcp())

local ip, port = "", 8080
while not server:bind("0.0.0.0", port) do port = port + 1 end
server:listen(5)

ip,port = server:getsockname()

print("binded at http://"..ip..":"..port)

while 1 do
	local client,err = server:accept()

	if client then
		local line, err = client:receive("*l")
		assert(not err)

		if     line:sub(1,4):find("GET") then
			local href = line:sub(5,-10)
			print("get", href)
		elseif line:sub(1,4):find("POST") then 
			local length, code
			repeat line, err = client:receive("*l")
				assert(not err)
				if line:sub(1,15) == "Content-Length:" then length = tonumber(line:sub(16, -1)) end
			until line == ""

			line, err = client:receive(length)
			print("2fa code recived!:", line)
			assert(not err)

			local f = io.write("./2fa.txt", "w")
			f:write(line)
			f:close()

			break
		end

		if not err then
			client:send("HTTP/1.0 200 OK\n\n\n")
			client:send([[
				<html>
					<head>
						<title>wrapper-lite-2fa</title>
					</head>
					<body>
						<h1>wrapper-lite-2fa</h1>
						<form method=POST>
							<label>2fa<input type=number name=2fa></input></label>
						</form>
					</body>
				</html>
			]])
		end
	else
		print("connection error:", err)
	end

	client:close()
end

server:close()

