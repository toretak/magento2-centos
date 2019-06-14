FROM centos:latest

ENV RH_PHP71_ROOT=/opt/rh/rh-php71
ENV BASH_ENV=${RH_PHP71_ROOT}/enable \
    ENV=${RH_PHP71_ROOT}/enable \
    PROMPT_COMMAND=". ${RH_PHP71_ROOT}/enable" \
    INSTALL_PKGS="git wget curl unzip dos2unix rpm-build rpmdevtools rh-php71-php-cli rh-php71-php-bcmath rh-php71-php-intl rh-php71-php-gd rh-php71-php-mbstring rh-php71-php-opcache rh-php71-php-soap rh-php71-php-zip rh-php71-php-xml rh-php71-php-pdo rh-php71-php-mysqlnd bsdtar"

RUN export tar='bsdtar'

RUN yum -y update --setopt=tsflags=nodocs && \
    yum -y install --setopt=tsflags=nodocs centos-release-scl-rh && \
    yum -y install --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum -y clean all

RUN source ${RH_PHP71_ROOT}/enable && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer global require hirak/prestissimo
