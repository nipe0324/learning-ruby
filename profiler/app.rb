# frozen_string_literal: true

require 'mysql2'
require 'mysql2-cs-bind'
require 'sinatra/base'
require 'sinatra/json'

class MyApp < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
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
  end

  get '/api/v1/users' do
    users = []
    rows = mysql_db.execute('SELECT id, name FROM users') do |row|
      users.push({
        id: user.id,
        name: user.name,
      })
    end

    json(
      status: true,
      data: {
        users:
      }
    )
  end
end
