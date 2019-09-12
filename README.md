# Rails new

```
rails new your-project
cd your-project
```

# Gemfile

```diff
+ gem 'sidekiq'
+ gem 'redis'
```

```
bundle install
```

# Job

```
bundle exec rails generate job sample
```

```
vim app/jobs/sample_job.rb
```

```diff
class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
+    puts 'Worked!'
+    puts Time.current
  end
end
```

# Config

```
vim config/application.rb
```

```diff
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsNewSidekiq
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

+    config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
```

# Redis

```
brew install redis (Mac)
redis-server
```

![image](https://user-images.githubusercontent.com/13635059/64828465-92f0a080-d603-11e9-8db6-2d24b39f7017.png)



# Worker

```
bundle exec sidekiq
```

![image](https://user-images.githubusercontent.com/13635059/64828575-085c7100-d604-11e9-86c0-31f814cf8b86.png)

# Run

```
bundle exec rails runner 'SampleJob.perform_later'
```

result in worker

```
2019-09-12T23:40:33.677Z pid=29375 tid=owiiogm93 class=SampleJob jid=0c56247c9f77a055dd35e78b INFO: start
Worked!
2019-09-12 23:40:33 UTC
2019-09-12T23:40:33.692Z pid=29375 tid=owiiogm93 class=SampleJob jid=0c56247c9f77a055dd35e78b elapsed=0.015 INFO: done
```
