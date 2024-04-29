cd ./src
rm ./sender_file/plaintext.txt

timer() {
    local start end runtime
    start=$(date +%s.%3N)
    "$@"
    end=$(date +%s.%3N)
    runtime=$(awk "BEGIN {print $end - $start}")
    echo "$@ : $runtime s."
    echo
}

commands=(
    "python3 ./generate_plaintext_and_hash.py"
    
    # Necessary for windows sender
    # In order to convert "CRLF" -> "LF"
    "dos2unix ./sender_file/plaintext.txt"
    
    "python3 ./compress_message_and_signature.py"
    "python3 ./encode_compressed_message.py"
    "cp ./sender_file/encrypted_message_and_symmetric_key.txt ./receiver_file/encrypted_message_and_symmetric_key.txt"
    "python3 ./decode_compressed_message.py"
    "python3 ./decompress.py"
    "python3 ./extract_plaintext_and_verify_signature.py"

    "python3 ./acknowledge.py"
    "cp ./receiver_file/encrypted_hash_value.txt ./sender_file/encrypted_hash_value.txt"
    "python3 ./verify_acknowledgement.py"
)

for cmd in "${commands[@]}"; do
    timer $cmd
done
