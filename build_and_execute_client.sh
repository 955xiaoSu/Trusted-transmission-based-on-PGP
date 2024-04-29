echo "Building the client container..."

# Choose proxy tool according to your enviroment 
proxychains sudo docker build -t crypto-app . -f Dockerfile-client

docker run -it --name crypto-client crypto-app
docker exec -it crypto-client bash