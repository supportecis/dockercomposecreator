FROM ruby:alpine
MAINTAINER Guillaume Peres <gperes@teikhos.eu>

RUN mkdir -p /usr/src/app /output

COPY Gemfile /usr/src/app/ 
COPY Gemfile.lock /usr/src/app/ 
RUN bundle install --clean --gemfile=/usr/src/app/Gemfile
COPY . /usr/src/app

WORKDIR /usr/src/app/

VOLUME ["/output"]
ENTRYPOINT ["ruby","dcc.rb"]
CMD ["help","generate"]