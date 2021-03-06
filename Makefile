test:
	crystal spec

run:
	crystal run examples/sidekiq.cr

profile:
	crystal compile bench/load.cr
# use `instruments -s` to find out your device name
	instruments -w MikeMBP -t "Time Profiler" ./load

bench:
	crystal compile --release bench/load.cr && ./load
	#crystal run --release bench/load.cr
	#ruby bench/load.rb

bin: clean
	time crystal compile -s --release -o sidekiq examples/sidekiq.cr
	time crystal compile -s --release -o sideweb examples/web.cr

clean:
	rm -f sidekiq sideweb

fixtures:
	cd spec/fixtures && ruby create_fixtures.rb

all: test bin bench

.PHONY: test run bench all bin clean fixtures
