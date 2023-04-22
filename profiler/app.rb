# frozen_string_literal: true

require 'mysql2'
require 'mysql2-cs-bind'
require 'sinatra/base'
require 'sinatra/json'

class MyApp < Sinatra::Base
  enable :logging

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader

    # require 'rack-mini-profiler'
    # use Rack::MiniProfiler
    # tmp = File.expand_path(__FILE__ + "/../tmp")
    # puts "tmp: #{tmp}"
    # Dir::mkdir(tmp) unless File.exist?(tmp)
    # Rack::MiniProfiler.config.storage = Rack::MiniProfiler::FileStore
    # Rack::MiniProfiler.config.storage_options = { path: tmp }

    # require 'rack-lineprof'
    # tmp = File.expand_path(__FILE__ + "/../tmp")
    # Dir::mkdir(tmp) unless File.exist?(tmp)
    # use Rack::Lineprof, profile: 'app.rb', logger: Logger.new('tmp/lineprof.log')

    # stackprof tmp/stackprof-cpu-*.dump --text --limit 10
    # stackprof tmp/stackprof-cpu-*.dump --text -m "MyApp#do_slow_stuff"
    # stackprof tmp/stackprof-wall-*.dump --text --limit 10 -m --file app.rb
    require 'stackprof'
    mode = :wall # cpu, object, custom
    use StackProf::Middleware,
      enabled: true,
      mode:,
      interval: 1000,
      save_every: 5,
      # raw: true,
      path: "tmp/stackprof-#{mode}-myapp.dump"
  end

  class HttpError < StandardError
    def initialize(message, code)
      super(message)
      @code = code
    end
  end

  error HttpError do
    e = env['sinatra.error']
    content_type :json
    status e.code
    JSON.dump(status: false)
  end

  helpers do
    def connect_mysql_db
      Mysql2::Client.new(
        host: '127.0.0.1',
        port: 3306,
        username: 'my-user',
        password: 'my-password',
        database: 'ruby-profiler-database',
        charset: 'utf8mb4',
        database_timezone: :utc,
        cast_booleans: true,
        symbolize_keys: true,
        reconnect: true,
      )
    end

    def mysql_db
      Thread.current[:mysql_db] ||= connect_mysql_db
    end

    def do_slow_stuff
      100_000.times.each do |n|
        n + 1
      end
    end

    def do_sleep(n)
      sleep n
    end
  end

  get '/users' do
    users = []
    mysql_db.query('SELECT id, name FROM users').each do |row|
      users.push({
        id: row[:id],
        name: row[:name],
      })
    end

    erb :users, locals: { users: users }
  end

  get '/api/v1/users' do
    users = []
    mysql_db.query('SELECT id, name FROM users').each do |row|
      users.push({
        id: row[:id],
        name: row[:name],
      })
    end

    do_slow_stuff
    do_sleep(3)
    do_sleep(2)
    do_sleep(1)

    json(
      status: true,
      data: {
        users:
      }
    )
  end
end
