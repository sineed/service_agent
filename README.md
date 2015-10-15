## Service Agent

This is a tool for site monitoring.

### Usage

```
git clone git@github.com:sineed/service_agent.git
cd service_agent
bundle install
rspec
bin/service_agent help monitor
bin/service_agent monitor yandex.ru -e test1@example.com @test2@yandex.ru -p 83216548709 80987654321
```

