docker build -t stephengrider/multi-client:latest -t stephengrider/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stephengrider/multi-client:latest
docker push stephengrider/multi-server:latest
docker push stephengrider/multi-worker:latest

docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA