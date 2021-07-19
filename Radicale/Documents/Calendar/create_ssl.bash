
# Change into the directory
cd ~/Documents/Calendar/

# Record the ip address (If a Domain Name is going to be used that could work)
ip route get 1 # ifconfig is another option

# Create the Key
openssl genrsa -out myselfsigned.key 2048
# Create the Certificate
openssl req -new -x509 -sha256     \
    -key radicale.key          \
    -out radicale.cer          \
    -days 800                      \
    -subj /CN=Radicale Calendar    \
    -addext  "subjectAltName = IP:192.168.50.190" # No Port number
    

#  Confirm ip address with `ip route get 1` or `ip addr | grep 192`
