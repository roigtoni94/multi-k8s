docker build -t roigtoni94/multi-client:latest -t roigtoni94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roigtoni94/multi-server:latest -t roigtoni94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t roigtoni94/multi-worker:latest -t roigtoni94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push roigtoni94/multi-client:latest
docker push roigtoni94/multi-server:latest
docker push roigtoni94/multi-worker:latest

docker push roigtoni94/multi-client:$SHA
docker push roigtoni94/multi-server:$SHA
docker push roigtoni94/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=roigtoni94/multi-server:$SHA
kubectl set image deployments/client-deployment client=roigtoni94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=roigtoni94/multi-worker:$SHA