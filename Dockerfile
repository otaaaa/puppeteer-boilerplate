FROM ghcr.io/puppeteer/puppeteer:22
USER pptruser
WORKDIR /home/pptruser
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
CMD ["npm", "start"]
