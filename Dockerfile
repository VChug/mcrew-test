# use a node base image
FROM 135512800999.dkr.ecr.us-east-1.amazonaws.com/hello-world

# set maintainer

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# tell docker what port to expose
EXPOSE 8000
