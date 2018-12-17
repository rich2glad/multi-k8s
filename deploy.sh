docker build -t rich2glad/multi-client:latest -t rich2glad/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t rich2glad/multi-server:latest -t rich2glad/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t rich2glad/multi-worker:latest -t rich2glad/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rich2glad/multi-client:latest
docker push rich2glad/multi-server:latest
docker push rich2glad/multi-worker:latest

docker push rich2glad/multi-client:$SHA
docker push rich2glad/multi-server:$SHA
docker push rich2glad/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rich2glad/multi-server:$SHA
kubectl set image deployments/client-deployment client=rich2glad/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rich2glad/multi-worker:$SHA