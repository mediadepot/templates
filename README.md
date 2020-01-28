# MediaDepot Portainer Templates
These templates are mostly based off of the templates available on https://tools.linuxserver.io/portainer.json with some
customization to work correctly with MediaDepot


# HTTPS
if you want to enable HTTPS, add the following label to your containers on creation with Portainer

```
- 'traefik.http.routers.CONTAINER_NAME.entrypoints=websecure'
- 'traefik.http.routers.CONTAINER_NAME.tls.certresolver=mydnschallenge'
```

# SSO Authentication
if you want to enable SSO Authentication via Authelia, add the following labels to your containers on creation with Portainer
Note: HTTPS must be enabled for Authelia to correctly redirect to the container.

```
- 'traefik.http.routers.CONTAINER_NAME.middlewares=authme'
- 'traefik.http.middlewares.authme.forwardauth.address=http://authelia:9091/api/verify?rd=https://login.${DEPOT_DOMAIN_NAME}/'
- 'traefik.http.middlewares.authme.forwardauth.trustforwardheader=true'
```

- TODO:
- change restart_policy to "unless-stopped" so that containers can be stopped and will not be automatically started when server restarts.
