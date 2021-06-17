docker build -t chrissamharris/multi-client:latest -t chrissamharris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chrissamharris/multi-server:latest -t chrissamharris/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t chrissamharris/multi-worker:latest -t chirssamharris/multi-client:$SHA -f ./worker/Dockerfile ./worker
docker push chrissamharris/multi-client:latest
docker push chrissamharris/multi-server:latest
docker push chrissamharris/multi-worker:latest

docker push chrissamharris/multi-client:$SHA
docker push chrissamharris/multi-server:$SHA
docker push chrissamharris/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chrissamharris/multi-server:$SHA
kubectl set image deployments/client-deployment client=chrissamharris/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chrissamharris/multi-worker:$SHA
