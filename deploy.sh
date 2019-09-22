docker build -t jannyman/multi-client:latest -t jannyman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jannyman/multi-server:latest -t jannyman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jannyman/multi-worker:latest -t jannyman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jannyman/multi-client:latest
docker push jannyman/multi-server:latest
docker push jannyman/multi-worker:latest

docker push jannyman/multi-client:$SHA
docker push jannyman/multi-server:$SHA
docker push jannyman/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jannyman/multi-server:$SHA
kubectl set image deployments/client-deployment client=jannyman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jannyman/multi-worker:$SHA