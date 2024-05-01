cd ./src
rm ./sender_file/plaintext.txt

timer() {
    local start end runtime
    start=$(date +%s.%3N)
    "$@"
    end=$(date +%s.%3N)
    runtime=$(awk "BEGIN {print $end - $start}")
    echo "$@ : ${runtime}s."
    echo
}

commands=(
    # Necessary for windows sender
    # In order to convert "CRLF" -> "LF"
    "dos2unix ./sender_file/basical_plaintext.txt"
   
    "python3 ./generate_plaintext_and_hash.py"
    "python3 ./compress_message_and_signature.py"
    "python3 ./encode_compressed_message.py"
    "python3 ./client_send.py"
    "python3 ./client_receive.py"
    "python3 ./verify_acknowledgement.py"
)

for cmd in "${commands[@]}"; do
    timer $cmd
done