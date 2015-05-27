require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry-byebug'

get '/' do
  redirect to('/index')
end

get '/index' do

  erb :index
end

get '/videos/new' do
  erb :new
end

post '/index' do
  sql = "insert into videos (title, description, url, genre) values ('#{params['title']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
  binding.pry
  run_sql(sql)
  redirect to('index')
end

get '/index' do
 sql =  "select * from videos"
 @videos = run_sql(sql)
end




def run_sql(sql)
  conn = PG.connect(dbname: 'radtube', host: 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end
  result
end


