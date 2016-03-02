#
#  Dockerfile for a GPDB SNE Sandbox GPCC Image
#

FROM pivotaldata/gpdb-base
MAINTAINER dcomingore@pivotal.io
MAINTAINER dbaskette@pivotal.io

#Load Files
COPY * /tmp/

#GPCC Core Install and Related Items
RUN     yum -y install crontabs \
        && service sshd start \
        && su gpadmin -l -c "gpstart -a" \
 	&& mv /tmp/gpcc.sh /usr/local/bin/gpcc.sh \
 	&& chmod +x /usr/local/bin/gpcc.sh  \
        && unzip /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.zip -d /tmp/ \
        && rm /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.zip \
        && echo -e "yes\n\nyes\nyes\n" | /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.bin \
	&& rm /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.bin

#Set up environmentals
EXPOSE 28080
VOLUME /gpdata

CMD echo "127.0.0.1 $(cat ~/orig_hostname)" >> /etc/hosts \
        && service sshd start \
        && su gpadmin -l -c "/usr/local/bin/gpcc.sh" \
	&& su gpadmin -l -c "source /home/gpadmin/gp-wlm/gp-wlm_path.sh;/bin/bash"
