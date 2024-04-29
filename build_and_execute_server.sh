echo "Building the server container..."

# Choose proxy tool according to your enviroment 
proxychains sudo docker build -t crypto-app-2 . -f Dockerfile-server

docker run -it --name crypto-server crypto-app-2
docker exec -it crypto-server bash