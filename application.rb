require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'

configure do
  set :server, :puma
end

before do
  content_type 'application/json'
end

get '/' do
  json message: 'Hello World!'
end

# Consumes pushes to the 'test' branch in the 'application' repository and runs the deployment process
post '/' do
  begin
    req = JSON.parse request.body.read

    repo = req['repository']

    # Checks whether the event was performed in the 'application' repository
    return 204 unless repo['type'] == 'repository' && repo['name'] == 'application'

    push = req['push']['changes'][0]['new']

    # Checks whether the event was a push to the 'test' branch
    return 204 unless push['type'] == 'branch' && push['name'] == 'test'

    # Runs the deployment process
    # `deployment.sh`

    return json message: 'The deployment process was run!'
  rescue
    return 204
  end
end
