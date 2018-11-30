docker build -t tomtobias/multi-client:latest -t tomtobias/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomtobias/multi-server:latest -t tomtobias/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomtobias/multi-worker:latest -t tomtobias/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tomtobias/multi-client:latest
docker push tomtobias/multi-server:latest
docker push tomtobias/multi-worker:latest

docker push tomtobias/multi-client:$SHA
docker push tomtobias/multi-server:$SHA
docker push tomtobias/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tomtobias/multi-server:$SHA
kubectl set image deployments/client-deployment client=tomtobias/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tomtobias/multi-worker:$SHA