TAG := nishitetsu-scraper

.built: Dockerfile Gemfile Gemfile.lock
	docker build -t $(TAG) .
	touch .built

shell: .built
	docker run --rm \
		-w /app \
		-v $$(pwd):/app \
		--name $(TAG) \
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
