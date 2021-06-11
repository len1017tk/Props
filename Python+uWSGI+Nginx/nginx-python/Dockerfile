# --------------------
# -- ベースイメージ --
# --------------------
FROM centos:8.3.2011

# ------------------
# -- インストール --
# ------------------
# python39-pip(Package Installer for Python)のインストール
#   pipはuWSGIをインストールするために必要。
#   依存関係からpython3.9も同時インストールされる。
RUN yum install -y python39-pip
# python39-devel(Python開発のためのライブラリとファイル群)のインストール
#   nginxをインストールするために必要。
RUN yum install -y python39-devel
# gcc(GNU Compiler Collection)のインストール
#   nginxをインストールするために必要。
RUN yum install -y gcc
# nginx(Webサーバ)のインストール
RUN yum install -y nginx
# yumのキャッシュ削除
RUN yum clean all

# ----------------
# -- リンク設定 --
# ----------------
# シンボリックリンク設定 python -> python3 -> python3.9
RUN unlink /usr/bin/python3
RUN ln -s /usr/bin/python3.9 /usr/bin/python3
RUN ln -s /usr/bin/python3 /usr/bin/python
# シンボリックリンク設定 pip -> pip3.8
RUN ln -s /usr/bin/pip3.9 /usr/bin/pip

# -----------
# -- uWSGI --
# -----------
# uWSGI(Web Server Gateway Interface)のインストール
RUN pip install uwsgi
# uWSGIの設定
RUN mkdir /etc/uwsgi
COPY ./conf/uwsgi.ini /etc/uwsgi/uwsgi.ini

# uWSGIの自動起動を有効化
COPY ./conf/uwsgi.service /etc/systemd/system/uwsgi.service
RUN systemctl enable uwsgi

# -----------
# -- nginx --
# -----------
# nginxの設定
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
RUN usermod -u 1000 nginx

# nginxの自動起動を有効化
RUN systemctl enable nginx

EXPOSE 8080

CMD /bin/bash