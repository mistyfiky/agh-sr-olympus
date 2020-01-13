FROM netdata/netdata
RUN echo -e "\
apollo:\n\
  name : 'apollo'\n\
  url  : 'http://apollo/server-status?auto'\n\
" >> /usr/lib/netdata/conf.d/python.d/apache.conf

