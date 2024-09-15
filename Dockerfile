FROM us-west1-docker.pkg.dev/fluted-volt-428205-p7/chereddy/ubuntu
RUN apt update
RUN apt install -y apache2
RUN apt install -y apache2-utils
RUN apt clean
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]