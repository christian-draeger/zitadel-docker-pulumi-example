# remove all docker containers including its volumes and network
docker rm -vf $(docker ps -a -q) && docker compose down -t 1

# start zitadel
docker compose up -d

# waiting for zitadel to be ready
while ! curl -s http://localhost:8080/healthz; do
    echo "waiting for zitadel to be ready"
    sleep 1
done

# run provisioning via pulumi
cd pulumi && bun install && bun run dev
