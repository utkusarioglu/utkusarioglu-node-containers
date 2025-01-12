ARG BASE_IMAGE
ARG BASE_TAG

FROM utkusarioglu/${BASE_IMAGE}:${BASE_TAG}

ARG NODE_VERSION
ARG APT_PACKAGES
ARG APT_PACKAGES_SILENT

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DEFAULT_USER=dev
ARG HOME_ABSPATH=/home/${DEFAULT_USER}
ARG BOOTSTAP_ABSPATH=${HOME_ABSPATH}/scripts/bootstrap

WORKDIR ${HOME_ABSPATH}

USER root

COPY home/scripts/ scripts/

RUN ls -alR ${HOME_ABSPATH}

RUN ${BOOTSTAP_ABSPATH}/linux/update-apt.sh

RUN ${BOOTSTAP_ABSPATH}/linux/install-apt.sh --no-check "${APT_PACKAGES_SILENT}"

RUN ${BOOTSTAP_ABSPATH}/linux/install-apt.sh "${APT_PACKAGES}"

RUN ${BOOTSTAP_ABSPATH}/node/install-nodejs.sh ${NODE_VERSION}

RUN ${BOOTSTAP_ABSPATH}/linux/clean-apt.sh

RUN ${BOOTSTAP_ABSPATH}/linux/set-permissions.sh \
  ${USER_ID} \
  ${GROUP_ID} \
  ${HOME_ABSPATH}

USER ${DEFAULT_USER}
