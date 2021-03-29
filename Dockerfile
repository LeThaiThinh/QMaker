FROM node:14.15.0

RUN mkdir /app
WORKDIR /app

COPY /sql,sequelize/ .

RUN npm install

CMD ["node", "src/index.js"]
