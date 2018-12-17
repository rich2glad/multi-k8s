docker build -t StephenGrider/multi-client:latest -t StephenGrider/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t StephenGrider/multi-server:latest -t StephenGrider/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t StephenGrider/multi-worker:latest -t StephenGrider/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push StephenGrider/multi-client:latest
docker push StephenGrider/multi-server:latest
docker push StephenGrider/multi-worker:latest

docker push StephenGrider/multi-client:$SHA
docker push StephenGrider/multi-server:$SHA
docker push StephenGrider/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=StephenGrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=StephenGrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=StephenGrider/multi-worker:$SHA