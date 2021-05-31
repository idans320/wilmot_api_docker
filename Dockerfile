FROM mongo
RUN apt-get update 
RUN apt-get install curl -y
RUN v=16 && curl -sL https://deb.nodesource.com/setup_$v.x | bash -
RUN apt-get install git nodejs -y &&  npm install yarn -g
RUN git clone https://github.com/idans320/wilmot_api ./wilmot_api
RUN apt-get install netcat -y 
RUN cd wilmot_api && yarn install
RUN cd wilmot_api && chmod +x generate_keys.sh && chmod +x add_admin.sh && ./generate_keys.sh
CMD mongod& until nc -z localhost 27017; do sleep 1; done; cd wilmot_api && ./add_admin.sh && yarn start