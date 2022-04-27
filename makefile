TAG := nishitetsu-scraper

.built: Dockerfile Gemfile Gemfile.lock
	docker build -t $(TAG) .
	touch .built

shell: .built
	docker run --rm \
		-w /app \
		-v $$(pwd):/app \
		-it $(TAG) bash

# Run `make shell` in another terminal, then
# run `bundle install`.
# Then run this command from a separate terminal.
# `make cat-gemfile-lock > Gemfile.lock
#   afterwards, edit the file and delete all lines before 'GEM'
cat-gemfile-lock: .built
	@docker exec $(TAG) cat Gemfile.lock

server: .built
	docker run --rm \
		-w /app \
		-v $$(pwd):/app \
		-p 4567:4567 \
		$(TAG) ./web.rb

deploy:
	git push heroku main

data/fukuoka-bus-stops.json: data/bus-stops/*.json
	bin/filter-and-de-dupe-bus-stops.rb

data/fukuoka-bus-stops-with-routes.json: data/bus-numbers/*.json
	bin/create-stops-with-numbers-list.rb
