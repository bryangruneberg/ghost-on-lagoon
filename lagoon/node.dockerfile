ARG GHOST_VERSION=5.82.12
FROM ghost:${GHOST_VERSION}-alpine as distrib

FROM uselagoon/node-18

ARG GHOST_VERSION

ENV NODE_ENV production
ENV GHOST_VERSION ${GHOST_VERSION}
ENV GHOST_CLI_VERSION 1.26.0
ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content

RUN set -eux; \
  npm install -g "ghost-cli@$GHOST_CLI_VERSION"; \
  npm cache clean --force

COPY --from=distrib ${GHOST_INSTALL} /var/lib/ghost
RUN rm -rf ${GHOST_CONTENT}
COPY --from=distrib ${GHOST_INSTALL}/content.orig ${GHOST_CONTENT}

COPY . ${GHOST_INSTALL}

RUN mkdir /home/.ghost && chown node:node /home/.ghost
USER 1000

WORKDIR "/var/lib/ghost"

CMD ["lagoon/ghost-run.sh"]
