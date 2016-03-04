FROM ubuntu:trusty
MAINTAINER Takahiro Shizuki <shizu@futuregadget.com>

ENV HOME /root


# set package repository mirror
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g" /etc/apt/sources.list

# dependencies
RUN apt-get update -o Acquire::ForceIPv4=true
RUN apt-get install -y bzip2 curl git man nkf ntp psmisc software-properties-common tmux unzip vim wget
RUN apt-get clean

# git latest
RUN add-apt-repository -y ppa:git-core/ppa
RUN apt-get update -o Acquire::ForceIPv4=true
RUN apt-get install -y git tig


# x window relations
RUN apt-get -y install python-appindicator xterm xfce4-terminal leafpad vim-gtk
RUN apt-get clean


# ansible2
RUN apt-get -y install python-dev python-pip
RUN pip install ansible markupsafe


# Option, User Environment

# japanese packages
RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add -
RUN wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add -
RUN wget https://www.ubuntulinux.jp/sources.list.d/wily.list -O /etc/apt/sources.list.d/ubuntu-ja.list
RUN apt-get update -o Acquire::ForceIPv4=true
RUN apt-get -y install language-pack-ja-base language-pack-ja fonts-ipafont-gothic dbus-x11
RUN apt-get -y install ibus-anthy
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
RUN apt-get clean

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

ENV GTK_IM_MODULE ibus
ENV QT_IM_MODULE ibus
ENV XMODIFIERS @im=ibus
RUN echo "ibus-daemon -drx" >> /root/.bashrc


# diff merge
WORKDIR /root/src
RUN wget http://download-us.sourcegear.com/DiffMerge/4.2.0/diffmerge_4.2.0.697.stable_amd64.deb
RUN dpkg -i diffmerge_4.2.0.697.stable_amd64.deb


# Set Env
ENV SHELL /bin/bash
RUN mkdir /root/.ssh
RUN chmod 600 /root/.ssh
ENV DISPLAY 192.168.99.1:0
ENV GIT_USER_NAME "Takahiro Shizuki"
ENV GIT_USER_EMAIL "shizu@futuregadget.com"

# git config
RUN git config --global push.default simple
RUN git config --global user.name $GIT_USER_NAME
RUN git config --global user.email $GIT_USER_EMAIL

# Set Timezone
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

# OpenGL env
env LIBGL_ALWAYS_INDIRECT 1
#env DRI_PRIME 1


# for wordpress
RUN apt-get -y install apache2 libapache2-mod-php5 php5-mysql mysql-server-5.6 mysql-client-5.6
RUN apt-get clean

RUN sed -i.bak -e "s%/var/www/html%/var/www/html/wordpress%g" /etc/apache2/sites-available/000-default.conf
RUN sed -i.bak -e "s%;date.timezone =%date.timezone = Tokyo/Asia%g" /etc/php5/apache2/php.ini


RUN mkdir -p /root/src
WORKDIR /root/src
RUN wget https://ja.wordpress.org/latest-ja.tar.gz -O /root/src/wordpress-latest-ja.tar.gz

WORKDIR /var/www/html
RUN tar xvfp /root/src/wordpress-latest-ja.tar.gz
RUN /bin/bash -c "service mysql start && mysql -e \"CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;\" && mysql -e \"CREATE USER wpadmin@localhost IDENTIFIED BY 'password';\" && mysql -e \"GRANT ALL ON wordpress.* TO wpadmin@localhost;\""

COPY wp-config.php /var/www/html/wordpress/
RUN chown -R www-data:www-data /var/www/html/wordpress


WORKDIR /root

EXPOSE 80
COPY entrypoint.sh /root/src/entrypoint.sh
RUN chmod +x /root/src/entrypoint.sh
ENTRYPOINT ["/root/src/entrypoint.sh"]


# option, visual studio code
#RUN add-apt-repository ppa:ubuntu-desktop/ubuntu-make
#RUN apt-get update
#RUN apt-get -y install ubuntu-make
#RUN apt-get -y install libgtk2.0-0 libgconf-2-4 libnss3 libasound-dev
#RUN /usr/bin/xfce4-terminal --command "umake web visual-studio-code"
#RUN ln -s /root/.local/share/umake/bin/visual-studio-code /usr/bin/visual-studio-code


# docker run usual
RUN /bin/bash -c 'echo docker run -it --rm -v /c/Users/\$USERNAME:/home/\$USERNAME -p 80:80 local/wordpress xfce4-terminal' # for working.
#http://192.168.99.100/

